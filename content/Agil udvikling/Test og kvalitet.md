---
tags: [test, kvalitet, acceptance-test, definition-of-done, agil, systemudvikling, eksamen]
kilder: ["Cohn kap. 6", "Kniberg: testing, sprint planning (kvalitet, DoD)", "Scrum Guide 2020"]
---

# Test og kvalitet

Del af [[Agil udvikling]]. Hvordan detaljerne i en story bliver til tests, hvornår noget er "done", og hvordan test passer ind i sprinten. TDD, CI og testautomatisering på programmørniveau står i [[XP#Test-First Programming]].

## Kvalitet er ikke til forhandling

*(Kniberg)*

| Ekstern kvalitet | Intern kvalitet |
|---|---|
| Det **brugerne** oplever (langsom, uintuitiv UI) | Usynligt for brugeren: designkonsistens, testdækning, læsbarhed, refaktorering |
| **En del af scope** → PO's beslutning | **Ikke til forhandling. Nogensinde.** (Næsten aldrig) |

- Lav intern kvalitet giver sjældent høj ekstern kvalitet: *"svært at bygge noget pænt på et råddent fundament"*
- **Alarmsignal:** *"Jeg respekterer jeres 6 point, men I kan sikkert lave et **quick fix** på halvdelen af tiden?"* PO bruger intern kvalitet som variabel. Styr i stedet mod **scope**: *"kan 'avanceret fejlhåndtering' blive en separat story?"*
- 🔄 2015: mere pragmatisk. Kortvarigt at ofre kvalitet (messe, prototype) kan give mening, men PO skal **forklare hvorfor** og **forpligte sig** til at betale den tekniske gæld tilbage

Scrum Guide siger det samme: under Sprinten **falder kvaliteten ikke** ([[Scrum#The Sprint]]).

---

## Acceptance tests

*(Cohn 6)*

> I stedet for lange lister af *"Systemet skal …"* bruges **tests** til at udfylde detaljerne i en user story. Testene dokumenterer **kundens antagelser**, også dem hun ikke vidste, hun havde.

*Eksempel:* "en Job Seeker kan se detaljer om et job". Kunden ved, at ikke alle firmaer angiver løn, og forventer, at labelen *"Salary range"* så heller ikke vises. **Det skal være en test**, ellers antager programmøren noget andet.

### Processen
1. **Test-noter** på **bagsiden af story-kortet**, når som helst nogen tænker på en test ([[User stories#Grundpremissen: kortet er en påmindelse, ikke en kontrakt]])
2. **Rigtige tests**, der demonstrerer, at storyen er korrekt og færdig

**Testene skrives FØR kodningen**: under samtalen med udviklerne, som en dedikeret indsats i starten af iterationen, og når nye tests opdages. Samme logik som Becks test-first, bare på et andet niveau: her skriver **kunden** tests før koden.

**Kundens fire spørgsmål:**
1. Hvad har programmørerne ellers brug for at vide?
2. **Hvad antager jeg om, hvordan storyen implementeres?**
3. Er der omstændigheder, hvor storyen opfører sig anderledes?
4. Hvad kan gå galt?

### Kunden specificerer testene
Kunden kan få hjælp fra en programmør eller tester, men skal **som minimum specificere de tests, der afgør, om storyen er færdig**.

⚠️ **Antimønsteret:** testeren fik sin forståelse fra **programmørerne** og testede, at de havde gjort, hvad de sagde. Ingen testede, at softwaren gjorde det, **brugerne ville have**. Sundt mønster: produktchef (organisatoriske mål) + tester (mistænksomt mindset) specificerer tests sammen, løbende.

### Hvor mange tests?
**Så længe de tilføjer værdi og afklaring.** Et udløbet MasterCard er nok, hvis alle kort behandles ens. Lavniveau-tilfælde (30. februar) hører til i udviklernes **unit tests**.

> **Test for bugs, not coverage.** Test er ikke en antagonistisk aktivitet; der er ingen *"I gotcha"*. Brug intuition og erfaring til at styre indsatsen.

### Automatisering: FIT og FitNesse
Kode fra én iteration kan brydes af en senere, så acceptancetests fra **alle** tidligere iterationer skal køres, og det vokser. **FIT** (Cunningham) og **FitNesse** lader kunden skrive tests som **tabeller**:

| CardType | Expiration | Number | valid() |
|---|---|---|---|
| Visa | 05/05 | 4123456789011 | true |
| MasterCard | 12/98 | 5123456789012345 | false |
| MasterCard | 12/05 | 42 | false |

Kunden laver tabellen, en programmør skriver koblingen til applikationen, og kolonnen farves grøn eller rød. Både kunde og udvikler kan køre dem.

| Testtype | Sikrer |
|---|---|
| **Functional** | At applikationen virker som forventet (det meste af story-test) |
| **User interface** | At UI-komponenter opfører sig korrekt |
| **Usability** | At den er let at bruge |
| **Performance** / **Stress** | Opførsel under belastning / ved ekstreme værdier |

| Udvikleren | Kunden |
|---|---|
| Kan **automatisere** acceptancetests | **Skrive** acceptancetests |
| Tænke over **flere** tests ved nye stories | **Køre** acceptancetests |
| **Unit-teste** sin kode | |

**Øvelse 6.1/6.2:** Hvem specificerer testene, og hvem hjælper? Hvorfor før kodningen?

---

## Definition of Done i praksis

Scrum Guide definerer DoD som Incrementets commitment ([[Scrum#Increment → Definition of Done]]). I praksis *(Kniberg)*:
- **PO og team skal være enige.** Er en story færdig, når koden er tjekket ind, eller når den er deployet og verificeret?
- Helst **"klar til produktion"**, ellers "deployet på testserver og klar til acceptancetest". Senere: *"færdig, når testeren siger det"*
- Ikke alle stories behandles ens ("Operations manual" er færdig, når driften accepterer den); **sund fornuft over tjeklister**
- 🔄 2015: *"That's a bit lame."* Brug en **konkret, kort tjekliste** som default, med fokus på det folk glemmer: *"opdatér release notes"*, *"ingen ny teknisk gæld"*, *"feedback fra rigtige brugere"*

Hvornår en story er klar til at blive **trukket ind** (Definition of Ready) står i [[Sprint planning#Definition of Ready og "how to demo"]].

---

## Test i sprinten

*(Kniberg)*

*"Det sværeste i Scrum, eller bare det sværeste i softwareudvikling."*

**Acceptance-test-fase** = hele perioden med test, debugging og re-release, indtil der er en version god nok til produktion.

| 2007 | 🔄 2015 |
|---|---|
| Betyder kvalitet noget, er en manuel acceptancetestfase med testere **uden for teamet** nødvendig | *"What a load of crap! … Baaaad author!"* Manuel test skal laves **af teamet, i sprinten**. *"Det var derfor, vi droppede vandfaldsmodellen."* |

Resten er mønstre **som midlertidig løsning**: maksimér kvaliteten fra teamet og effektiviteten af det manuelle testarbejde.

### Testere i teamet
> **"Tester" = en hvis primære kompetence er test, ikke en hvis rolle kun er test.** Tværfunktionel betyder ikke, at alle kan alt, men at alle er villige til mere end deres eget.

- Hele teamet er **kollektivt ansvarligt for kvalitet**. Testeren leder testarbejdet og parrer om automatisering
- **"Mr. T", sign-off-fyren:** intet er done, før han siger det. 🔄 2015: ikke længere fan, han bliver en **flaskehals**. Skal nogen signe af, bør det være **en rigtig bruger**
- **Intet at teste endnu?** Forbered tests og testmiljø, parprogrammér, eller tag **ikke-programmeringstasks** (testmiljø, deployment-dokumenter, afklaring af krav)
- **Er testeren flaskehals?** Gør alle til hans assistenter

### Lav mindre pr. sprint
> **Det er næsten altid billigere at bygge mindre, men stabilt, end at bygge meget og lave panik-hotfixes.**

### Sprint-cyklus vs. release
| Tilgang | Vurdering |
|---|---|
| "Byg ikke nyt, før det gamle er i produktion" | Kræver en ikke-timeboxet releaseperiode. 🔄 Intet problem, hvis **DoD = "i produktion"** |
| **"Byg nyt, men prioritér at få det gamle i produktion"** ✅ | Forvent tid til bugs fra sidste sprint. 🔄 Brug yesterday's weather |
| ❌ "Fokusér på at bygge nyt" | Rygsækken af næsten-klar kode bliver tungere og bremser alt |

🔄 2015: teams, der releaser dagligt, spørger *"hvorfor vente en hel sprint?"* Forkort releasecyklussen gradvist. **Begræns antal features i gang**: Kniberg har set firmaer blive **7× hurtigere** af det alene.

### Løb ikke fra det langsomste led
Kan testerne klare 3 features om ugen og udviklerne 6, så **planlæg 3** og brug resten på at løsne flaskehalsen: lad udviklere teste, byg **værktøjer og scripts** ✅, skriv **mere automatiseret testkode** ✅, eller ansæt testere. Samme logik som WIP-limits i [[Kanban]]. 🔄 2015: selvjusterende, hvis acceptancetest er i DoD.
