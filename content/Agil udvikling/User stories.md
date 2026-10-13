---
tags: [user-stories, invest, krav, agil, systemudvikling, eksamen]
kilder: ["Cohn kap. 2, 7, 13", "Beck kap. 7"]
---

# User stories

Del af [[Agil udvikling]]. Hvordan stories lægges i en backlog står i [[Product backlog]], hvordan de estimeres i [[Estimering og velocity]], og hvordan detaljerne bliver til tests i [[Test og kvalitet#Acceptance tests]].

## Grundpremissen: kortet er en påmindelse, ikke en kontrakt

> Stories er **negotiable**. Story-kortet er en kort beskrivelse, hvis detaljer forhandles i **en samtale mellem kunde og udviklingsteam** *(Cohn 2)*.

Beck angriber af samme grund ordet **"requirement"** ("noget obligatorisk"): ud af tusind siders krav opnås typisk hele forretningsværdien med de rigtige 5-20 %. **Resten var ikke krav** *(Beck 7)*. Beck lægger også vægt på, at en story **estimeres, så snart den er skrevet**: kender man prisen, kan man vælge informeret (*Ferrari til 150.000 $ eller minivan til 25.000 $?*).

### Hvor meget detalje hører på kortet?

| For lidt | Tilpas | For meget |
|---|---|---|
| Ingen holdepunkter for samtalen | En sætning eller to **som påmindelse** + noter om åbne spørgsmål | Læseren forveksler detalje med **præcision** og tror, samtalen er overflødig |

**For- og bagside** *(Cohn 2)*: forsiden har storyen og åbne spørgsmål; bagsiden har **tests** for det, der allerede er afklaret.

```
FORSIDE                                  BAGSIDE
Et firma kan betale for et               Test med Visa, MC, Amex (pass)
jobopslag med kreditkort.                Test med Diner's Club (fail)
                                         Test med udløbne kort
Note: Tager vi Discover-kort?            Test over og under $100
```

---

## Hvorfor stories?

*(Cohn 13)*

Otte fordele frem for **IEEE 830** ("The system shall …"), **use cases** og **scenarier**:

| Fordel | Kernen |
|---|---|
| **1. Verbal kommunikation** | Fokus flyttede fra **fælles forståelse** til **fælles dokument**, og det var dér, det gik galt |
| **2. Forståelige for alle** | Ingen teknisk eller domænejargon; historier huskes bedre |
| **3. Rette størrelse til planlægning** | IEEE 830 er for småt, use cases for store |
| **4. Virker med iterativ udvikling** | Man behøver ikke alle stories, før man koder den første |
| **5. Udsætter detaljer** | Pladsholder nu, detaljer når de bliver vigtige |
| **6. Opportunistisk udvikling** | Teamet kan skifte mellem højt og lavt detaljeniveau |
| **7. Participatory design** | Brugerne bliver deltagere i designet, ikke bare studieobjekter |
| **8. Tacit knowledge** | Mere snak → mere viden i teamet |

**Skrevne ord er upræcise:** *"Entrée comes with choice of soup or salad and bread"*: (soup or salad) and bread? *"Systemet **bør** vise en advarsel"*: må "bør" ignoreres? Ingen skriver under på en samtale, og *"100 perfekte venstresko giver ikke ét perfekt par"* (Poppendieck).

> **Mere værdifuldt end perfekte krav: tilstrækkelige stories + hyppige samtaler.**

**Størrelsen:** beder man en kunde prioritere tusindvis af "shall"-udsagn, bliver 90 % obligatoriske. Kan noget ikke prioriteres separat, skal det ikke skrives separat. Use cases er for store; mange små svinger for langt den anden vej. **IEEE 830** antager desuden, at alt der ikke står "shall" om, ikke skal laves, så man kan ikke se, om et krav mangler. Use case-skabeloner fører til **completism**.

**Opportunistisk udvikling:** Parnas & Clements: top-down fra krav til løsning sker aldrig, fordi brugerne ikke ved præcis hvad de vil have, detaljer først bliver klare undervejs, og ting ændrer sig. Guindon filmede udviklere, der sprang frit mellem abstraktionsniveauer.

| Ulempe ved stories | Afhjælpning |
|---|---|
| Svært at se **sammenhængen** på store projekter | Brugerroller; hold stories på højt niveau |
| **Sporbarhed** kan kræve dokumentation | Et dokument pr. iteration med stories + tests (~1 time om måneden) |
| **Skalerer dårligt** til meget store teams | Mange der ved lidt (dokumenter) vs. få der ved meget (samtale) |

---

## INVEST

*(Cohn 2, Bill Wake)*

| | Kriterium | Kernen |
|---|---|---|
| **I** | Independent | Undgå afhængigheder mellem stories |
| **N** | Negotiable | Kortet er en påmindelse om en samtale |
| **V** | Valuable | Værdifuld for **brugere eller købere**, ikke kun for udviklerne |
| **E** | Estimatable | Udviklerne skal kunne gætte på størrelsen |
| **S** | Small | Hverken epic eller mikro-opgave |
| **T** | Testable | Ellers ved man ikke, hvornår man er færdig |

### Independent
Afhængigheder giver prioriterings- og estimeringsproblemer. *Eksempel:* Visa/MasterCard/Amex: første korttype tager 3 dage, de næste 1 dag. Hvilken story får 3 dage? Udveje: **kombinér** dem ("betal med kreditkort", 5 dage), **split efter en anden dimension** ("én korttype" + "to yderligere"), eller som sidste udvej **to estimater** på kortet.

### Valuable
⚠️ Skeln mellem **user** og **purchaser**: *"al konfiguration læses fra ét centralt sted"* er værdifuld for køberen af 5.000 licenser, men ikke for brugeren, og det er fint. Det, der skal undgås, er stories, der **kun** er værdifulde for udviklerne:

| ❌ Teknologi-formulering | ✅ Omskrevet til brugerværdi |
|---|---|
| Alle databaseforbindelser går gennem en connection pool | Op til 50 brugere kan bruge applikationen med en 5-bruger-licens |
| Al fejlhåndtering sker gennem fælles klasser | Alle fejl præsenteres og logges konsistent |

Omskrivningen lader kunden prioritere og **fjerner teknologiantagelsen**. Samme greb som Knibergs omformulering af tech stories ([[Product backlog#Tech stories]]). **Bedste garanti: lad kunden skrive storyerne.**

### Estimatable

| Årsag til at en story ikke kan estimeres | Løsning |
|---|---|
| **Manglende domæneviden** | Tal med kunden. "Diabetes-screening" viste sig at være en simpel webformular |
| **Manglende teknisk viden** | En **spike**: et kort, **timeboxet** eksperiment. Én uestimerbar story bliver til spike + story |
| **For stor** | Bryd epicen op |

Epics er stadig nyttige som **pladsholdere** med et groft estimat.

### Small
Størrelsen afhænger af teamet og teknologien. Tommelfingerregler: **en halv dag til et par uger** for én eller to programmører, eller *"en størrelse, hvor brugeren føler sig berettiget til en kaffepause bagefter"* *(Cohn 7)*. Kniberg sigter efter 2-8 mandage og 5-15 stories pr. sprint ([[Sprint planning#Story-størrelse]]).

### Testable
**Består storyen sine tests, er den udviklet.** Utestbare stories dukker typisk op ved ikke-funktionelle krav:

| ❌ Ikke testbar | ✅ Omskrevet |
|---|---|
| En bruger må **aldrig** vente længe på en skærm | **Nye skærme vises inden for to sekunder i 95 % af tilfældene** |

> At demonstrere, at noget **aldrig** sker, er umuligt; at det **sjældent** sker, kan demonstreres.

Stræb efter **99 % automatisering**. Nogle få tests kan ikke automatiseres (*"en novice kan gennemføre workflows uden træning"*), men er stadig testbare.

---

## Opdeling af stories

### Hvilken slags epic?

*(Cohn 2)*

| Type | Kendetegn | Strategi |
|---|---|---|
| **Compound** | Består af flere kortere stories | Split i de konstituerende stories |
| **Complex** | Iboende stor pga. **usikkerhed** | Split i en **spike** (timeboxet) og en udviklende story |

**Compound**, "en bruger kan lægge sit CV op": kan deles efter **create/edit/delete** eller efter **datagrænser** (uddannelse, jobhistorik …). ⚠️ Gå ikke for langt: "kan indtaste en dato for hvert frivilligt arbejde" er for småt.

**Complex:** læg spiken i **en anden iteration**, så usikkerheden ikke smitter. Den vigtigste gevinst: kunden kan **prioritere undersøgelsen separat** fra ny funktionalitet.

### Split gennem lagene ("slice the cake")

*(Cohn 7)*

```
❌ Teknisk split:                       ✅ Hver story har lidt fra hvert lag:
• Udfyld en CV-formular (gemmes ikke)   • Indsend et CV med basisinformation
• Skriv CV-data til databasen           • Indsend et CV med al information
```

Hele kagestykker **reducerer risikoen** for overraskelser i et lag og **kan releases**. Samme princip på organisationsniveau giver feature-teams ([[Skalering af Scrum]]).

### For små stories
En story er for lille, når det tager længere at skrive og estimere den end at lave den (bugs, små UI-ændringer). **Kombinér** dem til en story på en halv til flere dages arbejde, fx fem bugs + en farveændring.

---

## Skrivevaner

*(Cohn 7)*

- **Start med goal stories:** tag hver brugerrolle og find dens mål (Job Seeker: søge jobs, automatisere søgning, gøre CV synligt, ansøge)
- **Skriv closed stories**, der slutter med et meningsfuldt mål. ❌ "En recruiter kan administrere sine annoncer" (bliver aldrig færdig). ✅ "… kan ændre udløbsdatoen på en annonce"
- **Constraints** markeres med "Constraint" og estimeres ikke ("understøt 50 samtidige brugere", "99,999 % oppetid"). Skriv helst en **automatiseret test**, der kører hver iteration
- **Size the story to the horizon:** små stories til det nære, brede til det fjerne
- **Hold UI'et ude** så længe som muligt; bland ikke krav med løsning
- **Ikke alt er en story:** UI-retningslinjer og interfaces mellem systemer kan kræve andre formater
- **Nummerér ikke kortene**; giv dem en kort titel. "Story 13.1" fører til abstrakte diskussioner

| Regel | ❌ | ✅ |
|---|---|---|
| **Inkludér brugerrollen** | En bruger kan lægge sit CV op | **En Job Seeker** kan lægge sit CV op |
| **Skriv til én bruger** | Job Seekers kan fjerne CV'er | En Job Seeker kan fjerne **sine egne** CV'er |
| **Aktiv form** | Et CV kan lægges op af en Job Seeker | En Job Seeker kan lægge et CV op |

**Connextra-skabelonen:**
> **Som en \<rolle\> vil jeg \<funktion\>, så \<forretningsværdi\>**

🔄 *Kniberg 2015* undrer sig over, at han ikke kendte den i 2007: den tvinger "men hvorfor?"-spørgsmålet frem.

**Kunden skriver** stories (evt. i en story writing workshop med udviklerne), fordi kunden prioriterer og skal forstå hver story. Ansvaret kan ikke overdrages til udviklerne. Fristes en udvikler til at bede om en story om teknologi, er det udviklerens ansvar i stedet at beskrive behovet som **værdi for bruger eller kunde** *(Cohn 2)*.

**Beck:** giv stories korte navne, skriv dem på **indekskort**, og hæng dem på en væg. Computeriserede stories leverer en brøkdel af værdien *(Beck 7)*.

## Øvelser
- **2.1** Er disse gode stories? *"En bruger kan hurtigt mestre systemet"* · *"En bruger kan redigere adressen på et CV"* · *"En bruger kan tilføje, redigere og slette flere CV'er"* · *"Alle runtime-fejl logges konsistent"*
- **2.2** Del op: *"En bruger kan lave og ændre automatiserede jobsøgningsagenter"*
- **7.2** Hvilken er passende stor og closed? *"gemme præferencer"* · *"ændre standard-kreditkort"* · *"logge på"*
- **7.4** Hvordan tester man constrainten *"Softwaren skal være nem at bruge"*?
- **13.4** Hvad er galt med *"All multipage reports should be numbered"*?
