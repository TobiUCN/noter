---
tags: [kvalitet, kvalitetsstyring, qa, standarder, iso-9001, reviews, inspektioner, metrics, systemudvikling, eksamen]
kilder: ["Sommerville kap. 24"]
---

# Kvalitetsstyring

Del af [[Agil udvikling]]. Hvordan organisationer sikrer, at software er **"fit for purpose"**: med processer, standarder, reviews og målinger. Den agile, team-nære side (acceptance tests, DoD, testere i teamet) står i [[Test og kvalitet]].

## Hvad kvalitetsstyring er

*(Sommerville 24)*

Formel kvalitetsstyring (QM) er vigtigst for **store systemer med lang levetid**, udviklet til eksterne kunder med en plandrevet proces. Den virker på to niveauer:

| Niveau | Opgave |
|---|---|
| **Organisation** | Etablere et framework af processer og standarder, der fører til kvalitet |
| **Projekt** | Anvende processerne, tjekke at de følges, og lave en **kvalitetsplan** |

| Quality assurance (QA) | Quality control (QC) |
|---|---|
| **Definere** processer og standarder, der skal føre til kvalitet | **Anvende** processerne og frasortere det, der ikke lever op til dem |

Begge er dele af quality management (begreberne kommer fra fremstillingsindustrien).

**QM-teamet skal være uafhængigt** af udviklingsteamet og rapportere til ledelsen *over* projektlederen. Projektlederen har budget og deadline og kan fristes til at ofre kvaliteten. I små firmaer er det praktisk umuligt; der har folk både udviklings- og kvalitetsansvar.

### Kvalitetsplanen
Definerer, hvad "høj kvalitet" betyder **for dette system**, så alle har en fælles forståelse. Humphreys skabelon:
1. **Product introduction**: produktet, markedet, kvalitetsforventninger
2. **Product plans**: releasedatoer, ansvar, distribution og service
3. **Process descriptions**: processer og standarder der skal bruges
4. **Quality goals**: de kritiske kvalitetsattributter og hvorfor
5. **Risks and risk management**: risici for produktkvaliteten ([[Risikostyring]])

Hold den **kort**, ellers bliver den ikke læst.

---

## Softwarekvalitet

*(Sommerville 24.1)*

Kvalitet i fremstilling = **overensstemmelse med specifikationen** (med tolerance). Det virker dårligt for software, fordi:
1. Krav er svære at skrive **komplet og entydigt**, og kunde og udvikler tolker dem forskelligt
2. Specifikationen er et **kompromis** mellem interessenter; de udeladte oplever systemet som dårligt
3. Nogle egenskaber (fx vedligeholdbarhed) kan **ikke måles direkte**

→ **Kvalitetsvurdering er subjektiv.** Den opleves især gennem de **ikke-funktionelle** egenskaber: manglende funktionalitet kan brugerne arbejde uden om, men et upålideligt eller langsomt system kan de ikke.

| Pålidelighed | Brugbarhed | Vedligehold | Effektivitet m.m. |
|---|---|---|---|
| Safety, security, reliability, resilience, robustness | Usability, learnability, understandability | Testability, adaptability, modularity, reusability, portability, complexity | Efficiency |

Intet system kan optimeres for alle (fx koster **sikkerhed ofte ydeevne**), så kvalitetsplanen skal vælge de vigtigste.

### Proces- vs. produktkvalitet
Traditionel QM antager: **god proces → godt produkt** (som i fabrikken: kalibrér maskinerne, så følger kvaliteten). For software er sammenhængen svagere, fordi software **designes, ikke fremstilles**: individuelle evner, nyhedsgrad og kommercielt pres betyder meget, og for meget standardisering kan **kvæle kreativiteten**.

> Derfor skal kvalitetsledere også opbygge en **kvalitetskultur**, hvor alle føler ansvar for kvaliteten, og støtte de uhåndgribelige sider (elegance, læsbarhed), som standarder ikke kan fange. Samme idé som Knibergs *"intern kvalitet er ikke til forhandling"* ([[Test og kvalitet#Kvalitet er ikke til forhandling]]).

---

## Standarder

*(Sommerville 24.2)*

**Hvorfor standarder:**
1. De **opsamler organisationens erfaring** (ofte dyrt købt ved trial and error)
2. De giver et **framework for, hvad kvalitet betyder** i en given sammenhæng
3. De giver **kontinuitet**, når en anden overtager arbejdet

| Produktstandarder | Processtandarder |
|---|---|
| Gælder **det, der produceres** | Gælder **måden, det produceres på** |
| Struktur for kravdokument, format for metodeheader, Java-kodestil, change request-formular | Gennemførelse af design review, versionsrelease, change control, testregistrering |

Udviklere oplever ofte standarder som bureaukrati. Få dem med ved at **inddrage udviklerne** i valget (og forklare hvorfor), **revidere standarderne** jævnligt og sørge for **værktøjsstøtte** (fx automatisk formattering). Projektlederen bør kunne tilpasse processtandarder til projektet.

### ISO 9001
- En **ramme for at lave standarder**, ikke en standard for softwareudvikling. Gælder alle brancher, der designer og vedligeholder produkter
- Kræver, at organisationen definerer og **dokumenterer sine processer** i en **kvalitetsmanual** og fører optegnelser, der viser, at de følges
- Uafhængige organer kan **certificere** virksomheden; nogle kunder kræver det

⚠️ **Certificering ≠ god software.** ISO 9001 måler **overholdelse af egne standarder**, ikke kvalitet som brugeren oplever den. Eksempel: en teststandard om "alle metoder kaldes mindst én gang" kan opfyldes af mangelfulde tests, og firmaet er stadig certificeret.

---

## Reviews og inspektioner

*(Sommerville 24.3)*

Kvalitetssikring, hvor **flere personer gennemgår** software, dokumentation og procesoptegnelser for fejl, mangler og brud på standarder. Supplerer test, fordi der **ikke skal eksekveres noget**: ufærdige systemer, UML-modeller og selve testene kan gennemgås.

- Formålet er **at forbedre kvaliteten, ikke at vurdere folk**. Kræver en kultur **uden skyld**
- Et **kvalitetsreview** er ikke et **progress review** (der handler om tid og budget)

### Review-processen
| Fase | Indhold |
|---|---|
| **Pre-review** | Planlægning (team, tid, sted, udsend dokumenter) og forberedelse: hver reviewer læser og finder fejl **individuelt** |
| **Review-møde** | Forfatteren *walker through* dokumentet. **Max 2 timer**. En chair styrer, en anden skriver beslutninger ned |
| **Post-review** | Ret fejl, refaktorér, omskriv. Chair tjekker, at alle kommentarer er håndteret |

Kerneteam på **3-4 personer**, inkl. en erfaren designer. Distribuerede teams kan reviewe via **delte, annoterede dokumenter**.

### Programinspektioner
Peer review, hvor teamet gennemgår kildekoden **linje for linje** ved hjælp af en **tjekliste** over typiske fejl (sprogspecifik og løbende opdateret). Roller fra IBM (Fagan): **forfatter, inspektør, scribe**, ledet af en **moderator**.

| Fejlklasse | Eksempel på tjek |
|---|---|
| Data | Er alle variabler initialiseret før brug? |
| Control | Terminerer hver løkke? Er alle cases dækket? |
| Input/output | Kan uventet input give korruption? |
| Interface | Rigtigt antal, type og rækkefølge af parametre? |
| Storage | Er dynamisk hukommelse allokeret og frigivet korrekt? |
| Exception | Er alle fejltilstande håndteret? |

**Effektivitet:** inspektioner finder ca. **60 %** af fejlene mod ca. **25 %** for unit test (Fagan, McConnell), men målt før udbredt testautomatisering. Mange firmaer tøver alligevel: testfolk tror ikke på det, og ledere ser omkostningen tidligt i projektet.

---

## Kvalitetsstyring i agil udvikling

*(Sommerville 24.4)*

Agil QM er **uformel og kulturbaseret** i stedet for dokumentbaseret. Kvalitet = **kodekvalitet**, sikret med refaktorering og TDD ([[XP#Test-First Programming]]). Agile miljøer er fundamentalt imod ISO 9001-bureaukratiet.

**Fælles god praksis:**
1. **Check before check-in**: få din kode reviewet af en kollega, før den tjekkes ind
2. **Never break the build**: test mod hele systemet; bryder du buildet, er det din topprioritet ([[XP#Continuous Integration]])
3. **Fix problems when you see them**: koden ejes af teamet, så ret selv andres fejl

Formelle inspektioner bruges sjældent. I stedet: **retrospektivet** ([[Under sprinten#Retrospektiv]]), hvor teamet kan beslutte at bruge en sprint på refaktorering, og **parprogrammering** ([[XP#Pair Programming]]).

| Parprogrammering som review | |
|---|---|
| **Styrke** | Begge kender koden i dybden og finder fejl, formelle inspektioner kan overse |
| **Svagheder** | Mindre objektivt: **fælles misforståelser** forstærkes, **parrets omdømme** (vil ikke sinke projektet), **tæt relation** gør det svært at kritisere |

**Hvornår agil QM ikke rækker:** uformel QM virker bedst til **produktudvikling**, hvor firmaet selv styrer specifikationen. Ved store systemer til eksterne kunder skal den suppleres, når
- **kunden har egne QM-processer** og forventer formelle rapporter
- **flere distribuerede teams** (måske fra forskellige firmaer) skal samarbejde ([[Skalering af Scrum]])
- systemet har **lang levetid**, og nye folk skal forstå tidligere beslutninger

Løsning: lad en sprint fokusere på essentiel dokumentation.

---

## Softwaremåling

*(Sommerville 24.5)*

En **software metric** er en objektivt målbar egenskab ved systemet, dokumentationen eller processen (linjer kode, antal fejlrapporter, person-dage).

| Control metrics (procesmetrikker) | Predictor metrics (produktmetrikker) |
|---|---|
| Understøtter **processtyring** | Forudsiger **softwarens egenskaber** |
| Tid for en proces, ressourceforbrug, antal hændelser (fejl fundet ved inspektion, change requests) | Cyklomatisk kompleksitet, identifikatorlængde, antal metoder pr. klasse |
| → *Skal processen ændres?* | → *Skal softwaren ændres? Er den klar til release?* |

**Interne vs. eksterne attributter:** eksterne kvaliteter (vedligeholdbarhed, brugbarhed) kan ikke måles direkte, så man måler **interne** (størrelse, kompleksitet) og antager en sammenhæng. Kitchenhams tre betingelser: den interne attribut skal **måles præcist**, der skal **være en sammenhæng**, og sammenhængen skal være **forstået og valideret** i en model.

### Produktmetrikker
| Dynamiske | Statiske |
|---|---|
| Målt på **kørende** program (svartid, antal fejl) | Målt på **repræsentationer** (kode, design, dokumenter) |
| Klar sammenhæng med **effektivitet og pålidelighed** | Indirekte sammenhæng med **kompleksitet, forståelighed, vedligeholdbarhed** |

| Statisk metrik | Betydning |
|---|---|
| **Fan-in / fan-out** | Fan-in højt = tæt koblet, ændringer spreder sig. Fan-out højt = kompleks kontrollogik |
| **Length of code** | Større kode → mere fejlbehæftet. **En af de mest pålidelige** forudsigere |
| **Cyklomatisk kompleksitet** | Kontrolkompleksitet, relateret til forståelighed |
| **Length of identifiers** | Længere navne → mere meningsfulde → mere forståeligt |
| **Depth of conditional nesting** | Dybt nestede if'er er svære at forstå og fejlbehæftede |
| **Fog index** | Gennemsnitlig ord- og sætningslængde i dokumenter |

**CK-suiten** (Chidamber & Kemerer), de mest brugte OO-metrikker:

| Metrik | Måler | Højt tal betyder |
|---|---|---|
| **WMC** (Weighted methods per class) | Antal metoder vægtet efter kompleksitet | Kompleks klasse, svær at genbruge |
| **DIT** (Depth of inheritance tree) | Arvehierarkiets dybde | Mange klasser skal forstås |
| **NOC** (Number of children) | Antal direkte subklasser (bredde) | Mere genbrug, men baseklassen skal valideres grundigt |
| **CBO** (Coupling between object classes) | Kobling mellem klasser | Ændringer i én klasse rammer andre |
| **RFC** (Response for a class) | Metoder der kan køres som svar på en besked | Mere kompleks, flere fejl |
| **LCOM** (Lack of cohesion in methods) | Metodepar uden vs. med fælles attributter | Omdiskuteret værdi |

⚠️ Der er stadig **ikke evidens** for, hvordan OO-metrikker hænger sammen med ekstern kvalitet.

### Komponentanalyse
1. Vælg målinger (ud fra **spørgsmål**, man vil have svar på)
2. Vælg komponenter (repræsentative eller de mest brugte)
3. Mål med værktøj
4. Find **anomalier** (usædvanligt høje/lave værdier, sammenlignet med historiske data)
5. Analysér dem. En høj værdi betyder **ikke nødvendigvis** dårlig kvalitet

### Måleflertydighed
> Data skal altid tolkes **i kontekst**.

*Eksempel:* en leder måler change requests og antager, at mange = utilfredse kunder. Efter procesforbedringer stiger tallet for nogle produkter og falder for andre. Men et fald kan betyde, at **kunderne er gået til en konkurrent**, og en stigning kan betyde, at **glade brugere** finder på nye ting, eller at de nu ved, at deres ønsker bliver taget alvorligt. Man skal vide **hvem, hvordan og hvorfor**.

### Hvorfor måling bruges lidt i praksis
ROI kan ikke kvantificeres, der mangler standarder, værktøjer koster, processerne er for variable, forskningen er lavet på plandrevet kode og ikke genbrug/agil, og målinger giver **overhead, som strider mod agile principper**.

### Software analytics
Data mining og machine learning på store mængder automatisk indsamlede data (crash-rapporter fra brugere, open source-repos på GitHub). Målet er **ikke generelle teorier**, men indsigt i **konkrete** problemer til beslutninger i realtid: hvor skal der testes, refaktoreres, hvornår skal der releases. Værktøjer skal være lette, hurtige, interaktive og måle bredt. Endnu umodent; data kommer mest fra store firmaer og produkter, og små firmaer har sjældent råd til indsamlingen.

---

## Eksamenspunkter

- **QA vs. QC**, og hvorfor QM-teamet skal være uafhængigt af projektlederen
- **Humphreys fem punkter** i en kvalitetsplan
- Hvorfor softwarekvalitet er **subjektiv** og især handler om **ikke-funktionelle** krav
- **Proceskvalitet ≠ produktkvalitet** for software; behovet for en kvalitetskultur
- **Produkt- vs. processtandarder** med eksempler
- ⚠️ Hvorfor **ISO 9001-certificering ikke garanterer** god software
- Review-processens **tre faser** og inspektionens **tjekliste** og roller
- **Agil QM**: de tre praksisser, parprogrammeringens svagheder, hvornår formel QM er nødvendig
- **Control vs. predictor metrics**, **statiske vs. dynamiske**, CK-suiten
- **Måleflertydighed**: change request-eksemplet
