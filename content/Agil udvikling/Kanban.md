---
tags: [kanban, lean, wip, flow, agil, case-study]
kilder: ["Kniberg & Skarin (2010), Kanban and Scrum: forord (Anderson), kap. 1, 4-6, 12, 14-15 og del II (Skarin) kap. 17-32"]
---

# Kanban

Del af [[Agil udvikling]]. Sammenligningen med Scrum står i [[Scrum vs Kanban]].

## Kanban i en nøddeskal

1. **Visualisér workflowet**: ét item pr. kort, navngivne kolonner viser, hvor det er
2. **Begræns WIP**: eksplicitte grænser for antal items i hver workflow state
3. **Mål lead time** (gennemsnitstid for ét item hele vejen igennem) og optimér, så den bliver **kort og forudsigelig**

"Kanban" = signalkort: et visuelt signal om, at der er plads til at trække nyt arbejde ind.

### Andersons pointer (forord)
- Kanban er **en tilgang til change management**, ikke en livscyklus eller projektstyringsmetode
- **Start med det, du gør nu** → map value stream → aftal WIP-limits → træk arbejde igennem
- Blokerede items stopper systemet ("stop the line") → høj kvalitet, mindre rework
- Transparens i **selve flowet** afslører flaskehalse, køer og spild
- **Evolution frem for revolution**, aftalt ved konsensus
- **Delayed commitment**: *"To slots er ledige. Lead time er 6 uger. Hvilke 2 ting vil I helst have om 6 uger?"*
- Microsoft 2004: **cycle time −92 %, throughput ×3, 98 % til tiden**

## WIP-limits

Simpelt board: To Do / Ongoing **(2)** / Done. Eneste forskel fra et Scrum-board er "2".
- Begræns WIP i **alle** states, også input-køen
- Med WIP-limits kan lead time **forudsiges** → **SLA'er** og realistiske planer
- Streng regel eller guideline? **Teamet vælger**

| WIP (4-personers team) | Hvad sker der |
|---|---|
| 1 | Folk sidder idle → items venter i To Do → **samlet lead time stiger** |
| 8 | Integrationsserveren går ned, men først ved 8 items reagerer de |
| 4 | De reagerer tidligere → bedre lead time |

→ WIP-limit tvinger teamet til at **fikse flaskehalsen** i stedet for at hobe ufærdigt arbejde op. Samme logik som at løbe fra det langsomste led ([[Test og kvalitet#Løb ikke fra det langsomste led]]).

**Tommelfingerregler:** for **lav** limit → idle mennesker; for **høj** limit → idle tasks og lang lead time. Rammer din kolonne limit, og du intet har at lave, så hjælp **downstream**. **To Do** er en buffer, fordi kunden ikke altid er tilgængelig.

## Et mindre trivielt board
`Backlog | Selected (2) | Dev: Ongoing / Done (3) | Production | Live!`

- **Selected (2):** teamet tager altid det øverste. PO må kun ændre Backlog og Selected
- Limit 3 **deles** af Ongoing og Done → udviklerne får incitament til at hjælpe med at få ting i produktion
- WIP-limit = **båndbredde**, lead time = **ping**
- Scrum-boardet viser ét teams sprint; Kanban-boardet viser **hele workflowet**

**One-piece flow:** et item flyder igennem uden at vente. *"The ideal work planning process should always provide the development team with best thing to work on next, no more and no less"* (Ladas).

**Design-spørgsmål:** hvilke kolonner (en state eller en kø)? Hvilke limits? Hvor strenge? Start simpelt.

## Kadencer og prioritering
Kanban kræver ikke timeboxes, så planlægning, release og forbedring kan adskilles:

| Team | Kadence |
|---|---|
| #1 | Én kadence: Scrum-iterationer |
| #2 | Release hver uge, planlægning hver 2., retro hver 4. |
| #3 | Event-drevet: planlæg, når To Do løber tør; release, når der er et sæt **MMF'er**; retro hver 4. uge |

Et prioriteret backlog er ikke påkrævet, men teamet skal have en **decision rule**: altid det øverste, det ældste, 20 % vedligehold/80 % features, røde først. Flere produkter: **farvede kort** eller **swimlanes**.

## Metrics
- **Average lead time** opdateres, hver gang et item når Done
- **Flaskehalse**: kolonne X er proppet, X+1 tom ("luftbobler")
- Feedback-loopet: for langt → langsom forbedring; for kort → **thrashing**

**Cumulative Flow Diagram:** tæl items i hver kolonne dagligt og stak dem. **Vandret afstand** = lead time, **lodret** = WIP, **hældning** = velocity. Den mest effektive vej til at blive hurtigere er at **udjævne flowet og begrænse arbejdet til kapaciteten**, ikke flere folk eller overarbejde.

---

## Case: technical operations

*(Skarin, del II)*

**Kontekst:** en skandinavisk spiludvikler, 2008. Scrum i udviklingsafdelingen fik software til at flyde, så **presset flyttede downstream** til technical operations (DBA'er, sysadmins, 2nd line support). "Os mod dem": begge sider mente, **"de burde ændre sig"**.

**Hvorfor Kanban og ikke Scrum?** Ops **omprioriterede dagligt**, så sprints passede dårligt, og der var brug for en **mindre konfrontatorisk** tilgang.

### Opstart
- **Halvdags workshop** med en simulering; **fist of five** (konsensus = alle ≥ 3)
- **Stakeholders** blev varslet: teamet ville begynde at **sige nej**, stå fast på kvalitet og fjerne lavprioriterede items
- Hvert team designede **selv** sit board. Flowet går **opad**, prioritet fra venstre mod højre:

| Rækker (state) | Kolonner (arbejdstype) |
|---|---|
| Backlog · Ready for WIP (tasks ≤ 8 t) · Work in progress · Done | Release · Support · Unplanned · Project A/B |

### WIP og at sige nej
- Første limit: **2n − 1** (4 personer = 7): *"hver kan have én aktiv og én ventende"*. Enhver generøs limit ville have virket
- **WIP i story points var ubrugeligt**; tæl items
- **Sig nej ved boardet**: tag stakeholderen med derhen. **Overflow-sektion**, når det var for konfrontatorisk; efter 2 uger blev den ryddet
- Kun tasks **> 1 time** på boardet; resten er **"white noise"**

### Estimering
- Story points blev behandlet som mandetimer; hver story estimeres **én gang**
- *"Always check with the board"*: en leder lovede levering "inden ugens udgang", men boardet viste 25 % efter en uge
- **Planning poker virkede ikke for ops** (ujævn viden, kun én talte). Egne løsninger: **shifting and reviewing** (senior + junior pr. story, grupperne reviewer hinanden) og **senior high-level pass**

### Rytme og impediments
- **Daily standup** foran boardet efter den fælles scrum of scrums; **ugentlig planning** (opdatér board → "Wall of Done", se tilbage, justér WIP, estimér nye projekter)
- Teams kunne give lederne **max 2 "team impediments"**; teamet afgør, hvornår de er løst. *Eksempel:* ops fik ikke hjælp ved bugs → **round-robin**, hvor ét dev-team er "on call" for ops hver sprint

### Metrics
| Metric | Pro | Con |
|---|---|---|
| Cycle time | Let, ingen estimering | Tager ikke højde for størrelse |
| Velocity pr. arbejdstype | Præcis | Mere at tracke |
| Kø-længder | **Leading indicator**, hurtig | Siger ikke, om årsagen er efterspørgsel eller kapacitet |

De valgte **velocity pr. arbejdstype + kø-længder**. Burndowns var overkill for projekter under 4 uger.

### Resultater
- Efter **3 måneder** blev sysadmin-teamet kåret som **"best performing team"**; før var de flaskehalsen
- **One operations contact per team**: direkte kontakt i stedet for en tilfældig person fra køen
- DBA: **omvendt sammenhæng** mellem antal små supportopgaver og velocity: **white noise betyder noget**

### Lessons learned
1. **Når WIP falder, dukker constraints op.** Færre samtidige projekter (3 → 2 → 1) gjorde problemerne uden for teamet synlige
2. **Hug ikke boardet i sten.** 2-3 redesigns før det virkede
3. **Vær ikke bange for at eksperimentere og fejle.** *"We fail the moment we perceive there is an end point."*
