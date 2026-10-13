---
tags: [distribuerede-systemer, transaktioner, acid, serial-equivalence, recoverability, nested-transactions, eksamen]
kilder: ["Coulouris 16.1–16.3"]
---

# Transaktioner og ACID

Del af [[Distribuerede systemer]]. Metoderne til at opnå isolation står i [[Concurrency control]], og transaktioner over flere servere i [[Distribuerede transaktioner og 2PC]].

> En **transaktion** er en sekvens af operationer, som serveren udfører som **én udelelig enhed**: enten gennemføres det hele og gemmes i permanent storage, eller også slettes alle effekter *(Coulouris 16.1)*.

**Recoverable objects** = objekter, der kan genskabes efter et crash. Gennemgående eksempel: en bank med `Account` (`deposit`, `withdraw`, `getBalance`, `setBalance`) og `Branch` (`create`, `lookUp`, `branchTotal`).

Atomare enkeltoperationer (`synchronized`, mutex) løser kun interferens mellem tråde, ikke alt-eller-intet på tværs af flere kald.

## ACID

| | Egenskab |
|---|---|
| **A**tomicity | Alt-eller-intet: **failure atomicity** (også ved crash) + durability |
| **C**onsistency | Fra én konsistent tilstand til en anden |
| **I**solation | Ingen interferens; **mellemliggende effekter er usynlige** |
| **D**urability | Effekterne overlever crash |

> Coulouris medtager **ikke consistency** i sin egen liste: det er **programmørens ansvar**. Holder et objekt summen af alle saldi, skal `deposit`/`withdraw` også opdatere det.

## Fejlmodel (Lampson)
Algoritmerne virker ved **forudsigelige fejl**, ikke katastrofer. Det er crash- og omission-fejl, **ikke Byzantine** ([[Fundamentale modeller#Fejlmodellen]]).

| Komponent | Antagelse |
|---|---|
| **Permanent storage** | Writes kan fejle; reads opdager dårlige blokke via checksum |
| **Servere** | Crasher; en ny proces starter tom og kører recovery. Fejlende processorer **tvinges til at crashe** |
| **Kommunikation** | Beskeder mistes, duplikeres, korrumperes (opdages). **Forfalskede beskeder = katastrofe** |

Løsningen er **stable storage** (hver blok på to diskblokke) og **reliable RPC**.

## Coordinator og livsforløb

| Operation | Betydning |
|---|---|
| `openTransaction() → trans` | Returnerer et unikt **TID** |
| `closeTransaction(trans) → (commit, abort)` | Afslutter; returværdien er udfaldet |
| `abortTransaction(trans)` | Aborterer |

TID'et sendes med hver invocation, eksplicit eller **implicit via middleware** (CORBA OTS). En transaktion kan **committe**, **aborteres af klienten** eller **aborteres af serveren** (klienten får ERROR ved næste operation). Ved servercrash aborterer erstatningen alle ucommittede transaktioner; mod klientcrash har hver transaktion en **expiry time**.

---

## Concurrency-problemerne

*(Coulouris 16.2)*

Problemerne opstår, **selvom hver enkelt operation er atomar**.

| Problem | Hvad sker der | Eksempel |
|---|---|---|
| **Lost update** | To transaktioner **læser begge den gamle værdi**, før nogen skriver | T og U øger B med 10 %. Begge læser $200 → **$220 i stedet for $242** |
| **Inconsistent retrievals** | En retrieval ser en **halvt gennemført** opdatering | V flytter $100 fra A til B; `branchTotal` midt imellem giver **$300 i stedet for $400** |

### Serial equivalence
> Et **serially equivalent interleaving** har **samme samlede effekt, som hvis transaktionerne var kørt én ad gangen** i en eller anden rækkefølge.

**Konfliktende operationer** = deres samlede effekt afhænger af rækkefølgen:

| Op. i T1 | Op. i T2 | Konflikt? |
|---|---|---|
| `read` | `read` | **Nej** |
| `read` | `write` | **Ja** |
| `write` | `write` | **Ja** |

> **Definition (eksamensstof):** to transaktioner er serially equivalent **hvis og kun hvis alle par af konfliktende operationer udføres i samme rækkefølge på alle de objekter, de begge tilgår.**

**Fælde:** det er **ikke nok**, at hvert objekt for sig er serialiseret. Tilgår T objekt `i` først og U objekt `j` først, er rækkefølgen ikke den samme på begge.

Det samme krav skal holde **globalt** over flere servere ([[Concurrency control#Concurrency control over flere servere]]).

### Recoverability: når transaktioner aborterer
Serial equivalence er ikke nok, fordi transaktioner kan **abortere**.

**Dirty read:** U læser T's ucommittede værdi og committer, hvorefter T aborterer. U har set en værdi, der aldrig har eksisteret.
- **Recoverability:** udsæt **commit**, til den observerede transaktion har committet. Aborterer den, må U også abortere
- **Cascading aborts:** undgås ved kun at læse committede værdier, altså ved at udsætte **read**. En stærkere betingelse

**Premature write** (`write` mod `write`): implementeres abort ved at gendanne **before images**, går det galt:

| Scenarie (A=$100, T sætter 105, U sætter 110) | Korrekt | Med before images |
|---|---|---|
| U aborterer, T committer | $105 | $105 ✓ |
| U committer, T aborterer | $110 | **$100** ✗ |
| T aborterer, så U aborterer | $100 | **$105** ✗ |

Løsning: udsæt **write**, til tidligere skrivere er færdige.

> En udførelse er **strict**, hvis **både read og write** udsættes, til alle tidligere skrivere af objektet har committet eller aborteret. **Strict execution håndhæver isolation.**

| Niveau | Krav |
|---|---|
| Serially equivalent | Konfliktende par i samme rækkefølge overalt |
| Recoverable | Udsæt **commit** |
| Undgå cascading aborts | Udsæt **read** |
| **Strict** | Udsæt **read og write** |

### Tentative versions
Opdateringer sker i **tentative versions** i volatile memory, ét privat sæt pr. transaktion. `read` henter derfra, hvis muligt. Ved **commit** overføres de i **ét skridt** og skrives til permanent storage; ved **abort** slettes de.

---

## Nested transactions

*(Coulouris 16.3)*

Transaktioner sammensat af andre. Den yderste er **top-level**, resten **subtransactions**. Modsat en **flat transaction**, hvor dele ikke kan committes hver for sig.

**Fordele:** (1) **mere concurrency**: søskende kan køre samtidig, på forskellige servere endda parallelt, og (2) **uafhængig commit/abort**: en forælder kan reagere på et barns abort.

### Commit-reglerne (eksamensstof)
1. En transaktion må først afslutte, **når dens børn er færdige**
2. Et færdigt barn vælger **provisional commit** eller **abort**; abort er endelig
3. Aborterer en forælder, **aborterer alle efterkommere**, også provisionally committede
4. Aborterer et barn, **vælger forælderen selv**, om den vil abortere
5. Committer top-level, committer alle provisionally committede, **medmindre en forfader har aborteret**

> **Effekterne er ikke permanente, før top-level committer.** Provisional commit gemmer intet i permanent storage; det er noget andet end 2PC's *prepared* ([[Distribuerede transaktioner og 2PC]]).

### Låseregler
- **Låse arves fra barn til forælder**, når barnet committer; top-level holder dem til slut
- **En forælder kører ikke samtidig med sine børn**: barnet låner låsen
- Søskende **tager tur** om forælderens låse
