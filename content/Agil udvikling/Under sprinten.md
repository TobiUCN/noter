---
tags: [scrum, task-board, daily-scrum, sprint-review, retrospektiv, scrum-master, agil, systemudvikling]
kilder: ["Scrum Guide 2020", "Cohn kap. 15", "Kniberg: sprint backlogs, team room, daily scrums, demos, retrospectives, slack, SM-checklist", "Beck kap. 7"]
---

# Under sprinten

Del af [[Agil udvikling]]. Fra sprinten er planlagt ([[Sprint planning]]) til den næste starter: **task board → teamrum → daily scrum → review → retrospektiv → slack.** Sprintens regler og timeboxe står i [[Scrum#Events]].

## Task boardet

Kniberg endte med et **vægbaseret task board**. 🔄 2015: *"Stadig mit førstevalg."* Distribuerede teams: board-visning på en stor skærm på hver lokation.

```
┌──────────────┬──────────────┬──────────────┬─────────────┐
│ Ikke tjekket │  Tjekket ud  │    Done ✓    │  Burndown   │
│ ud           │ (arbejdes på │              ├─────────────┤
│ Story + tasks│  i dag)      │              │ Unplanned   │
│ →→→→→→→→→→→→ │→→→→→→→→→→→→→ │              ├─────────────┤
│              │              │              │ Next        │
└──────────────┴──────────────┴──────────────┴─────────────┘
```

- Tasks vandrer mod højre; når alle er færdige, **hopper storyen til Done**
- **Unplanned items** noteres (nyttigt på retroen)
- Hold det **simpelt**; ny, ren board hver sprint
- 🔄 2015: **avatarer på magneter**, to pr. person, begrænser indirekte **WIP**: *"Stop starting, start finishing"* (samme idé som [[Kanban]])

Det er en **informative workspace**: en iagttager skal kunne se, hvordan projektet går, på **15 sekunder** *(Beck 7)*. Tag diagrammer ned, når de ikke længere opdateres.

**Burndown:** plot summen af resterende estimater **hver dag efter daily scrum**. 🔄 2015: med korte sprints og visuelle boards springer mange den over.

**Advarselstegn** (SM sørger for, at teamet reagerer): burndown langt over linjen → **fjern** stories; langt under → **tilføj**; lavt prioriterede tasks i gang før de vigtige; mange unplanned items.

**Sporbarhed?** Tag et foto af boardet. 🔄 2015: *"Traceability hugely overrated"*; skriv story-ID i commit-beskeden.

## Teamrummet

- **Design corner** foran task boardet: whiteboard med skitser, sprint-væg, plads til at stå
- **Seat the team together!** Audibility, visibility, isolation. Folk vil ikke flytte; efter én sprint er alle enige. Beck siger det samme (**Sit Together**) og pointerer, at *"det er altid et menneskeproblem"* ([[XP#Sit Together]])
- **PO:** 2007: tæt på, men ikke ved teamets borde. **🔄 2015: "I was wrong! Dead wrong."** De bedste teams har PO **indlejret**
- **Managere og coaches:** gå tæt på i en periode, så ud igen. Coach SM under fire øjne. 🔄 2015: *"Sørg for, at teamet har alt det skal bruge, og hold dig så væk."*

---

## Daily scrum

**Definitionen** *(Scrum Guide)*: **15 minutter for Developers**, samme tid og sted, for at inspicere fremdrift mod **Sprint Goal** og tilpasse planen. Developers vælger selv struktur; guiden foreskriver **ikke** de tre spørgsmål. Er PO eller SM i gang med items, deltager de **som Developers**. Det er ikke det eneste tidspunkt, planen må justeres.

### I praksis
- Stående, så tidligt som muligt, **foran task boardet** (*"nothing can beat that"*) *(Kniberg)*. Max 15 min (Cohn: aldrig over 30)
- **De tre spørgsmål** *(Cohn 2004)*: hvad lavede du i går, hvad laver du i dag, hvilke forhindringer? 🔄 2015: med fokus på **sprint goal**, eller Dan Norths *"hvad er den bedste 'i dag', vi kan få?"* **Lad det aldrig blive kedeligt**

**Reglerne** *(Cohn 15)*:
- **Ikke en grilling fra SM**; commitments gives **til hinanden**
- **Løs ikke problemer på mødet**; aftal, hvem der mødes bagefter
- **Kun aktive deltagere taler**; chefen må lytte
- **SM spørger aldrig** *"hvor meget tid er der tilbage?"*
- Perfekt tidspunkt at **omfordele** arbejde

**Opdatering af boardet:** **hele teamet** vedligeholder sprint backloggen, ikke SM alene. 🔄 2015: opdatér i realtid og drop task-estimater, så mødet bruges til at **kommunikere**, ikke administrere.

**For sent?** En dåse man betaler i, eller en fjollet sang. Teamet skal selv finde på det.

**"Jeg ved ikke, hvad jeg skal lave":** gennemgå boardet med teamet · foreslå **parprogrammering** · find skjulte tasks (*"vi har ingen testserver"*) · er sprint goal nået, så tag fra "Next" · sidste udvej: skam, tildel, gruppepres eller "vær butler i dag". ⚠️ Må SM ofte ty til tricks, er SM måske selv den største forhindring for selvorganisering.

---

## Sprint review

**Definitionen** *(Scrum Guide)*: inspicér Sprintens **udfald** og afgør fremtidige tilpasninger sammen med **key stakeholders**. Gennemgå, hvad der blev opnået, og **hvad der har ændret sig i omverdenen**; backloggen kan justeres. En **arbejdssession**, ikke bare en demo. Maks. 4 timer; næstsidste event.

**Cohn 15:** hver sprint leverer et **potentially shippable product increment**. Reviewet er **uformelt**: ingen PowerPoint, **max 2 timers forberedelse**. Vurderes mod **sprint goal**.

> **🔄 2015:** *"Hvorfor kaldte jeg det 'sprint demo'?!"* **Demo** er envejs; **review** er tovejs. **Sprint review handler om feedback.**

### Hvorfor alle sprints ender med et review

*(Kniberg)*
Teamet får **anerkendelse**, andre lærer, interessenter giver **feedback**, det er **socialt**, og det **tvinger teamet til at blive færdigt**. Uden demoer: bunker af 99 %-færdigt. En pinlig demo er **bitter medicin**: næste gang viser man to ting i stedet for fem, *men de VIRKER*.

**Tjekliste:** præsentér sprint goal · vis **kørende kode**, ingen flashy slides · højt tempo · **forretningsniveau** · lad publikum prøve selv · nævn små bugfixes, men demo dem ikke.

**Det ikke-demonstrerbare** (skalerbarhed til 10.000 brugere): *"Hvordan ved du, det er færdigt?"* → *"Jeg har en loadtest-rapport"* → **så er rapporten din demo.**

---

## Retrospektiv

**Definitionen** *(Scrum Guide)*: planlæg, hvordan **kvalitet og effektivitet** øges. Inspicér individer, interaktioner, processer, værktøjer og Definition of Done. De vigtigste forbedringer adresseres hurtigst muligt, evt. i næste Sprint Backlog. Maks. 3 timer; **afslutter Sprinten**.

- **Det vigtigste er, at det sker.** Jo mere stressede, jo mere brug for det (*"for travlt med at fælde træer til at slibe saven"*)
- **2007:** næstvigtigste event. **🔄 2015: det vigtigste, punktum**
- Buy-in er større, når idéen kommer *fra teamet*
- *Kniberg & Skarin:* **start med retrospektiver**, hvis I ikke holder dem, og sørg for, at de fører til forandring

### Knibergs format
1-3 timer (🔄 1 t for 2-ugers sprints + en lang session hvert par måneder) · PO og hele teamet · **ikke i teamrummet** · SM opsummerer sprinten · **runden:** hver siger uafbrudt hvad der var godt, hvad der kunne være bedre · **estimeret vs. faktisk velocity**.

| Good | Could have done better | Improvements |
|---|---|---|
| Ville gøre det igen | Ville gøre det anderledes | Konkrete idéer |

Derefter **dot voting** (tre magneter pr. person), og følg op næste gang. Ikke for mange forbedringer pr. sprint. 🔄 2015: variér formatet (Retromat), men det simple virker.

**Spred læringen:** Kniberg deltog i alle retros som **knowledge bridge**. 🔄 2015: **byt facilitatorer** mellem teams.

**At ændre eller ej:** ofte er det **nok at identificere problemet klart**. Hver ændring har en pris.

| Retro-fund | Typisk handling |
|---|---|
| *"Vi burde have brudt stories mere ned"* | Ingen; teamet ordner det selv |
| *"For mange forstyrrelser"* | Registrér dem; kanalisér via SM/PO; roterende **"goalkeeper"** (🔄 virker) |
| *"Vi overcommittede"* | Ingen; det sker næppe igen |
| *"Kontoret er larmende"* | Bedre miljø, eller flyt teamet |

> **🔄 2015:** **"Sprint commitment"** er siden 2014 blevet **"sprint forecast"**. Planen er en **prognose**, ikke et løfte. Leverer man konsekvent mindre, så brug **yesterday's weather** strengt.

---

## Slack

*"Hvis du altid sprinter, jogger du i virkeligheden bare"* *(Kniberg)*. Team og PO skal fordøje idéer efter review og retro.

| Dårligt | Bedre | Bedst? |
|---|---|---|
| Mandag: demo, retro **og** planning | Demo + retro fredag, planning mandag | Demo + retro torsdag, **lab day** fredag, planning mandag |

Minimum: **retro og næste planning ikke samme dag.** **Lab days** / Spotifys **hack weeks** giver innovation; bloker en halv dag om ugen som "unbookable".

**Beck** har samme idé som praksis: **Slack** = læg små opgaver ind, der kan droppes, så man **holder sine aftaler**. Firehjulstræk-analogien: kør på to hjul, så har du reserve, når du sidder fast *(Beck 7)*. Se [[XP#Slack]].

## Scrum master-tjekliste

*(Kniberg)*

| Start af sprint | Hver dag | Slut af sprint |
|---|---|---|
| Sprint info page, link fra dashboard, print og hæng op | Daily scrum starter og slutter **til tiden** | Varsl og åbn **review** |
| Mail til alle: sprint startet, goal | Tilføj/fjern stories, så planen holder, og **giv PO besked** | **Retro** med team og PO |
| Sprint-statistik: velocity, teamstørrelse, længde | Forhindringer løses eller eskaleres | Opdatér statistik |

> **🔄 2015:** Gør dig **overflødig**. SM'er, der bliver *"Scrum admin"*, **hindrer selvorganisering**.
