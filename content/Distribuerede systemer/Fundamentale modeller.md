---
tags: [distribuerede-systemer, modeller, synkron, asynkron, logisk-tid, fejlmodel, sikkerhedsmodel, eksamen]
kilder: ["Coulouris 2.4"]
---

# Fundamentale modeller

Del af [[Distribuerede systemer]]. Alle arkitekturer fra [[Arkitekturmodeller]] består af **processer, der kommunikerer ved at sende beskeder**. En fundamental model indeholder kun de essentielle ingredienser for at ræsonnere om systemets adfærd *(Coulouris 2.4)*:
- **Gør alle antagelser eksplicitte**
- **Generalisér** om, hvad der er muligt og umuligt givet antagelserne

> Ved man, hvad designet **afhænger af og ikke afhænger af**, skal man bare spørge, om antagelserne holder.

| Model | Hjælper med |
|---|---|
| **Interaction** | Kommunikation med betydelige forsinkelser og begrænset præcision i fælles tidsopfattelse |
| **Failure** | At klassificere fejl, så systemer kan designes til at tolerere hver type |
| **Security** | At klassificere angreb som grundlag for trusselsanalyse |

---

## Interaktionsmodellen

En **distribueret algoritme** definerer de skridt, **hver** proces tager, **inklusive beskederne** imellem dem. Det er svært, fordi hastighed og timing ikke kan forudsiges, og fordi fejl skal håndteres. Hver proces' tilstand er **fuldstændig privat**.

To afgørende faktorer: **kommunikationsperformance er ofte begrænsende**, og **ét globalt tidsbegreb er umuligt**.

### Kommunikationskanaler

| Begreb | Definition |
|---|---|
| **Latency** | Forsinkelsen fra en besked begynder at blive sendt, til den begynder at blive modtaget |
| **Bandwidth** | Mængden af information, der kan overføres pr. tid. Deles mellem kanaler |
| **Jitter** | **Variationen** i leveringstid. Relevant for multimedie |

Latency består af (1) tiden for den første bit at nå frem, (2) forsinkelsen ved at **få adgang til netværket** (fx Ethernet, der venter på et frit medie, [[Link layer]]), og (3) tiden i **OS'ets kommunikationsservices** hos begge parter.

### Ure
Ure **drifter**, og **driftraterne er forskellige**. **Clock drift rate** = hvor hurtigt et ur afviger fra et perfekt referenceur. GPS giver ca. 1 µs nøjagtighed, men virker ikke indendørs; timing-beskeder fra en præcis kilde påvirkes af variable beskedforsinkelser.

### Synkrone vs. asynkrone systemer

| | **Synkront** (Hadzilacos & Toueg) | **Asynkront** |
|---|---|---|
| Tid pr. processkridt | Kendte øvre og nedre grænser | **Ingen grænse** |
| Beskedforsinkelse | Kendt, begrænset | **Ingen grænse** |
| Clock drift | Kendt grænse | **Vilkårlig** |
| Fejldetektion | **Timeouts** virker | En timeout siger kun "svarer ikke" |
| Realisme | Kan bygges, men grænserne skal **garanteres** | **Modellerer internettet præcist** |

> **Enhver løsning, der er gyldig for et asynkront system, er også gyldig for et synkront.** Nogle problemer (fx deadlines i multimediestrømme) kræver dog en synkron model.

### Pepperland
To divisioner, *Apple* og *Orange*, på hver sin bakke skal blive enige om **hvem** der leder angrebet, og **hvornår**.
- **Hvem** kan afgøres selv asynkront: send antal soldater, den største leder
- **Hvornår** er umuligt asynkront, fordi budbringeren kan tage 5 minutter eller 3 timer
- **Synkront** (min ≤ forsinkelse ≤ max): lederen sender "Charge!", venter *min* minutter og angriber; den anden angriber 1 minut efter modtagelsen. Garanteret **efter**, men højst **max − min + 1** minutter senere

### Event ordering og logisk tid
*Eksempel:* X sender `Meeting`, Y og Z svarer `Re: Meeting`. Pga. leveringsforsinkelser kan A se svarene **før** det oprindelige. Ure kan ikke synkroniseres perfekt, så **Lamport (1978)** foreslog **logisk tid**: en ordning uden ure. Vi ved, at afsendelse sker **før** modtagelse, og at et svar sendes **efter** modtagelsen af det, der svares på. Logisk tid tildeler hvert event et tal, så senere events har højere tal.

---

## Fejlmodellen

Taksonomi (Hadzilacos & Toueg): **omission**, **arbitrary** og **timing** failures.

### Omission failures
**Proces:** den vigtigste er **crash**. I et asynkront system kan en timeout kun indikere, at processen ikke svarer: den kan være crashet, langsom, eller beskeder kan være tabt. Et crash er **fail-stop**, hvis andre **med sikkerhed** kan opdage det (muligt i et synkront system).

**Kommunikation:** `send` lægger beskeden i en **outgoing buffer**, kanalen transporterer den til modtagerens **incoming buffer**, og `receive` tager den ud. **"Dropping messages"** skyldes typisk manglende bufferplads (fx en fuld routerkø, [[Network layer og IP routing]]) eller en checksum-fejl.

### Arbitrary (Byzantine) failures
Den **værst tænkelige** fejlsemantik: en proces kan returnere forkerte værdier, undlade skridt eller tage utilsigtede skridt. Kan ikke opdages ved at se, om processen svarer. Kanaler kan korrumpere, opdigte eller duplikere beskeder, men det er sjældent, fordi **checksums** og **sekvensnumre** fanger det.

### Timing failures
Kun i **synkrone** systemer: et ur overskrider sin driftgrænse, eller en proces/kanal overskrider sin tidsgrænse (**performance failure**). I et asynkront system kan man ikke tale om timing failures, fordi der ikke er givet garantier.

### Oversigt

| Fejlklasse | Rammer | Beskrivelse |
|---|---|---|
| **Fail-stop** | Proces | Standser; andre **kan** opdage det |
| **Crash** | Proces | Standser; andre kan **ikke nødvendigvis** opdage det |
| **Omission** | Kanal | Beskeden når aldrig modtagerens buffer |
| **Send-omission** | Proces | `send` gennemføres, men beskeden lægges ikke i bufferen |
| **Receive-omission** | Proces | Beskeden ligger i bufferen, men modtages ikke |
| **Arbitrary (Byzantine)** | Proces eller kanal | Vilkårlig adfærd |
| **Clock** | Proces | Uret overskrider driftgrænsen |
| **Performance** | Proces / kanal | Overskrider tidsgrænsen |

Omission, timing og performance failures kaldes **benign**; de fleste fejl er benigne.

### Masking
> En service **maskerer** en fejl ved at **skjule den** eller **konvertere den til en mere acceptabel type**.

- **Checksums** konverterer en arbitrary failure til en **omission failure**
- Omission skjules med en protokol, der **gensender**
- Et proces-crash kan maskeres ved at erstatte processen og genskabe tilstanden fra disk (præcis det, 2PC-recovery gør, [[Distribuerede transaktioner og 2PC]])

### Reliable communication
| Egenskab | Definition |
|---|---|
| **Validity** | Enhver besked i den udgående buffer bliver **til sidst leveret** |
| **Integrity** | Beskeden er **identisk** med den sendte, og **ingen leveres to gange** |

Trusler mod integrity: protokoller, der gensender uden at afvise dubletter (løses med **sekvensnumre**), og **ondsindede brugere** (kræver sikkerhed).

### Umuligheden af enighed ved kommunikationsfejl
Kan Apple og Orange blive enige, hvis budbringere kan **tilfangetages**? **Nej.** Bevis ved modstrid: betragt den **sidste besked** i en protokol, der opnår enighed. Den kunne være tabt, så resultatet må være det samme uden den; altså kan den undværes. Gentag, indtil der ingen beskeder er. Tilsvarende kan man asynkront ikke skelne "den anden er besejret" fra "budbringeren er forsinket".

---

## Sikkerhedsmodellen

> **Sikkerhed opnås ved at sikre de processer og kanaler, der bruges til interaktionerne, og ved at beskytte de objekter, de indkapsler, mod uautoriseret adgang.**

**Objekter** har **access rights**. Hver invocation og hvert resultat har en **principal** (bruger eller proces) bag sig. Serveren skal **verificere principalens identitet** og tjekke **adgangsrettighederne**; klienten kan tilsvarende tjekke serverens identitet.

### Fjenden
En **fjende** kan **sende enhver besked til enhver proces** og **læse eller kopiere enhver besked** mellem to processer, fra en lovligt eller ulovligt tilsluttet maskine.

| Trussel mod | Hvad |
|---|---|
| **Servere** | Kan ikke afgøre, hvilken principal der står bag et kald; kildeadresser kan **forfalskes** |
| **Klienter** | Kan ikke afgøre, om svaret kommer fra den rigtige server eller en **spoofer** |
| **Kanaler** | Beskeder kan **kopieres, ændres, injiceres** eller **genafspilles** (replay) |
| **Andet** | **Denial of service** og **mobile code** (trojanske heste) |

### Secure channels
Truslerne besejres med **kryptografi** (to processer, der deler en hemmelighed) og **autentificering** (en krypteret del af beskeden beviser afsenderen). Sammen bygger de **secure channels** oven på eksisterende kommunikation, med **tre egenskaber**:
1. Hver proces **kender pålideligt identiteten** af principalen bag den anden
2. Kanalen sikrer **fortrolighed og integritet**
3. Hver besked har et **fysisk eller logisk tidsstempel**, der forhindrer **replay og omordning**

Eksempler: VPN og SSL/TLS ([[Sikre protokoller - TLS, IPsec og WiFi]]).

> Sikkerhed er ikke bare adgangskontrol og sikre kanaler. Teknikkerne koster, og truslerne kommer fra netværket, det fysiske miljø og mennesker. Resultatet af analysen er en **threat model**: angrebsformer + risici og konsekvenser. Det uddybes i [[Sikkerhed#Design af sikre systemer|Sikkerhed]] og [[Trusler og angreb]].
