---
tags: [agil, systemudvikling, moc, eksamen]
kilder: ["Scrum Guide 2020", "Kniberg: Scrum and XP from the Trenches (2. udg. 2015)", "Cohn: User Stories Applied", "Beck: XP Explained (2. udg.)", "Kniberg & Skarin: Kanban and Scrum (2010)", "Sommerville: Software Engineering (10. udg.)"]
---

# Agil udvikling

Indgangen til systemudviklingsemnet. Noterne er organiseret efter **emne**, og hver note samler, hvad de forskellige kilder siger om det. Kilden står ved sætningerne, fx *(Cohn 8)* eller *(Kniberg)*.

## Noterne

| Note | Indhold |
|---|---|
| [[Scrum]] | Definitionen: teori, pilarer, værdier, accountabilities, events, artefakter og commitments |
| [[User stories]] | Hvorfor stories, INVEST, opdeling, skrivevaner |
| [[Product backlog]] | Backlog'en i teori og praksis, refinement, tech stories, bugs |
| [[Estimering og velocity]] | Story points, planning poker, velocity |
| [[Release planning]] | Fra estimater til en dato; MoSCoW |
| [[Sprint planning]] | Sprint goal, valg af stories, nedbrydning i tasks, sprintlængde |
| [[Under sprinten]] | Task board, daily scrum, review, retrospektiv, slack |
| [[Test og kvalitet]] | Acceptance tests, Definition of Done, testere i teamet, kvalitet som ikke-forhandlingsbar |
| [[XP]] | Værdier, principper og de 13 primary practices + Knibergs erfaringer |
| [[Kanban]] | Principper, WIP-limits, board-design, metrics og case study |
| [[Scrum vs Kanban]] | Ligheder og forskelle punkt for punkt |
| [[Skalering af Scrum]] | Flere teams, scrum-of-scrums, distribuerede teams |
| [[Risikostyring]] | Projekt-/produkt-/forretningsrisici, risikoprocessen, strategier, risiko i agil |
| [[Kvalitetsstyring]] | QA/QC, standarder og ISO 9001, reviews og inspektioner, agil QM, metrikker |

## Kilderne og deres vinkel

| Kilde | Genre | Bidrager med |
|---|---|---|
| **Scrum Guide 2020** (Schwaber & Sutherland) | Definitionen | *Hvad Scrum er*. Alt andet (story points, burndown, planning poker) er taktik, ikke Scrum |
| **Cohn**, User Stories Applied (2004) | Lærebog: *sådan bør det gøres* | Kravet (storyen) og planlægning omkring den. XP-sprog: *customer*, *iteration* |
| **Kniberg**, Trenches (2007 + kommentarer 2015) | Feltrapport: *sådan gjorde vi* | Hele Scrum-maskineriet i hverdagen. Scrum-sprog: *product owner*, *sprint* |
| **Beck**, XP Explained | Teori og model | *Hvorfor* (værdier) og *hvad* (praksisser) |
| **Kniberg & Skarin** (2010) | Sammenligning + case | Kanban vs. Scrum og en case fra technical operations |
| **Sommerville**, Software Engineering (10. udg.) | Bred lærebog, plandrevet udgangspunkt | Projektledelse og kvalitetsstyring, og hvordan de tilpasses agil |

> **Kniberg 2. udg. er en "director's cut":** originalteksten fra 2007 er uændret, og i 2015 har han tilføjet kommentarer, hvor han ofte **modsiger sig selv**. De er markeret med **🔄 2015** i noterne og er de mest eksamensrelevante, fordi de viser *hvorfor* en praksis blev droppet.

## Versionsforskelle man skal kunne se

Brug Scrum Guide 2020 som facit, men kend forskellene:

| Emne | Cohn (2004) | Kniberg (2007) | 🔄 Kniberg (2015) | Scrum Guide 2020 |
|---|---|---|---|---|
| Sprintlængde | 30 dage | 3 uger | 2-3 uger er normen | ≤ 1 måned |
| Teamstørrelse | 4-7 udviklere | 3-8 | 3-8 | ≤ 10 i alt |
| Daily scrum | 3 spørgsmål | Samme | Fokus på **sprint goal** | Ingen faste spørgsmål |
| Sprintplanen | "Commitment" | "Commitment" | **"Forecast"** | Forecast; sprint goal er commitment |
| Prioritering | Kunden sorterer | "Importance"-tal | Bare **sortér listen** | Ordered backlog |
| Demo | Review, ingen slides | "Sprint demo" | Kald det **review**: feedback | Sprint Review |
| Backlog refinement | — | Inde i sprint planning | **Separat møde** | Løbende aktivitet |

## Værktøjs-tankegangen

*(Kniberg & Skarin kap. 2)*

- **Sammenlign for forståelse, ikke for dom.** Kniv eller gaffel? Afhænger af konteksten
- **Intet værktøj er komplet eller perfekt**; de giver kun constraints og guidelines
- **Værdien af et værktøj er, at det begrænser dine muligheder.** En proces, der tillader alt, er ubrugelig
- Projekt-succes ≠ værktøjs-succes: et projekt kan lykkes på trods af et værktøj

### Prescriptive ↔ adaptive

| Værktøj | Placering | Hvorfor |
|---|---|---|
| RUP | Meget prescriptive | 30+ roller, 20+ aktiviteter, 70+ artefakter. Du får **for meget** og skal fjerne |
| XP | Prescriptive | Det meste af Scrum + engineering practices |
| Scrum | Midt | Ingen engineering practices, men iterationer og tværfaglige teams. Du får **for lidt** og skal tilføje |
| Kanban | Meget adaptive | Kun: visualisér workflow + begræns WIP. *"Just inches from Do Whatever, but still surprisingly powerful"* |

Agile metoder kaldes "lightweight", fordi de er mindre prescriptive (*individuals and interactions over processes and tools*).

### Mix and match
- Kniberg kan næsten ikke forestille sig et succesfuldt Scrum-team uden det meste af XP
- Mange Kanban-teams holder daily standup; nogle Scrum-teams begrænser kø-størrelser
- ⚠️ Respektér værktøjets constraints: fjerner du fx timeboxede iterationer, så **kald det ikke Scrum**. Samme pointe som Scrum Guidens "Scrum er immutable" ([[Scrum]])

*"Scrum is just a tool. You choose when and how to use it. Don't be a slave to it!"*

## Scrum og XP er komplementære

> Scrum fokuserer på **management- og organiseringspraksisser**; XP på **programmeringspraksisserne**. De dækker forskellige områder og virker derfor godt sammen *(Kniberg)*.

Ifølge Jeff Sutherland gjorde det allerførste Scrum-team alle XP-praksisserne. Ken Schwaber overtalte ham til at tage engineering-praksisserne *ud* for at holde Scrum simpelt. Det spredte formentlig Scrum hurtigere, men mange teams lider, fordi de mangler netop de tekniske praksisser, der gør agil udvikling **bæredygtig**. Derfor siger Scrum Guide intet om TDD, CI eller parprogrammering ([[XP]]).

## De røde tråde på tværs af kilderne

1. **Samtale > dokument.** Cohn: kortet er en påmindelse om en samtale. Beck: et tusind sider langt dokument beviser ikke, at man værdsætter kommunikation. Kniberg: planning poker og "how to demo" fremprovokerer misforståelser tidligt
2. **Kort feedback slår perfekt planlægning.** Beck (feedback som værdi), Cohn (estimér og test tidligt), Kniberg (CI og automatiserede tests)
3. **Relative, grove estimater er nok.** Velocity korrigerer selv for bias. 🔄 Kniberg dropper focus factor og task-estimater
4. **Kunden/PO ejer *hvad* og *rækkefølge*; teamet ejer *hvor meget* og *hvordan*.** Cohn: "når der er uenighed om rækkefølgen, vinder kunden. Hver gang"
5. **Kun færdigt arbejde tæller.** Ingen halve point; "done" skal være defineret
6. **Planer er hypoteser.** Sig "5-7 iterationer", aldrig "3. juni"
7. **Bæredygtigt tempo er produktivitet, ikke blødsødenhed.** Beck (energized work), Kniberg (bedre kvalitet *og* produktivitet efter overarbejdet blev fjernet)
8. **Eksperimentér og tilpas.** *"The only real failure is the failure to learn from failure"* *(Kniberg & Skarin)*. Start med retrospektiver, og stop aldrig med at eksperimentere
