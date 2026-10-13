---
tags: [kanban, scrum, sammenligning, agil, lean, eksamen]
kilder: ["Kniberg & Skarin (2010), Kanban and Scrum, del I kap. 3-16"]
---

# Scrum vs Kanban

Del af [[Agil udvikling]]. Mekanikken står i [[Scrum]] og [[Kanban]].

> Scrum og Kanban er **værktøjer**, ikke mål. Målet er **kontinuerlig læring**: vælg, kombinér og eksperimentér.

**Introduktionens case:** et support-team fejler sine sprints, fordi akutte issues dukker op dagligt; selv 1-dags sprints passer ikke. → **Drop sprints, brug Kanban**, men behold backlog, selvorganisering, daily og retros.

## Ligheder
- Begge er **Lean og Agile**, **empiriske** (Kaizen = inspect & adapt)
- Begge bruger **pull scheduling** (≈ JIT)
- Begge **begrænser WIP**, på hver sin måde
- Begge bruger **transparens** til procesforbedring
- Begge leverer **tidligt og ofte**, med **selvorganiserende teams** og arbejde i små stykker
- Releaseplanen optimeres løbende ud fra data (velocity / lead time)

## Forskelle

| Scrum | Kanban |
|---|---|
| Timeboxede iterationer påkrævet | Valgfrit; separate kadencer, evt. event-drevet |
| Commitment pr. iteration | Valgfrit |
| Default metric: **velocity** | Default metric: **lead time** |
| Tværfaglige teams påkrævet | Specialistteams tilladt |
| Items skal kunne nås i én sprint | Ingen bestemt størrelse |
| Burndown påkrævet | Ingen bestemt diagramtype |
| WIP begrænset **indirekte** (pr. sprint) | WIP begrænset **direkte** (pr. workflow state) |
| Estimering påkrævet | Valgfri |
| Kan ikke tilføje items midt i iterationen | Kan tilføje, når der er kapacitet |
| Sprint backlog ejes af ét team | Board kan deles af flere teams |
| 3 roller | Ingen roller foreskrevet |
| Board nulstilles mellem sprints | Board er vedvarende |
| Prioriteret backlog påkrævet | Prioritering valgfri |

(Tabellen afspejler Scrum anno 2010; Scrum Guide 2020 kræver fx ikke længere burndown eller estimering i en bestemt form.)

## Punkt for punkt

**Roller:** Kanban har ingen, men man **må** have en PO. Tilføj kun roller, der tilfører værdi; en projektleder på et lille projekt er spild eller værre. **Less is more.**

**Timeboxede iterationer:** en Scrum-iteration samler **planlægning, procesforbedring og release** i én kadence med fast scope. Kanban kan adskille dem ([[Kanban#Kadencer og prioritering]]).

**WIP:** Scrum har en **implicit** limit, fordi sprintens scope er fast; **velocity bliver i praksis Scrums WIP-limit**. Sætter et Scrum-team en eksplicit limit på Ongoing: *"tadaaa! Scrum-boardet er blevet et Kanban-board."*

**Ændringer undervejs:**
- **Scrum:** *"Nej, vi har committet til A+B+C+D. Læg E i backloggen."*
- **Kanban:** *"Læg E i To Do, men limit er 2, så fjern C eller D."* **One item out = one item in**
- **Responstid** på en ny prioritet: Scrum ≈ **halv sprintlængde**; Kanban = når der bliver kapacitet

**Board og ejerskab:** Scrum-boardet ejes af **ét tværfagligt team** og ryddes efter hver sprint (*"som at vaske op efter middagen"*). Kanban-boardet hører til **ét workflow**, er vedvarende, og teamet skal selv lave **ground rules**.

**Item-størrelse:** Scrum: skal kunne nås i én sprint. Kanban: ingen regel, men jagten på kort lead time giver incitament til små items.

**Estimering:** Scrum estimerer relativ størrelse ([[Estimering og velocity]]). Kanban: valgfrit; alternativer er at måle **items pr. uge** eller lead time pr. MMF → **SLA** (*"et MMF leveres altid inden for 15 dage"*).

**Flere produkter:** tænk på "Product Backlog" som et **Team Backlog**, der tvinger prioritering mellem produkterne. Kanban: farvede kort eller swimlanes.

**Lean:** Scrum batcher arbejde i iterationer, men sammenlignet med 2-4 releases om året er shippable kode hver 2. uge ekstremt lean. **Under 1 uges iterationer → overvej at droppe timeboxes helt.**

**Mindre forskelle:**
- **Daily meeting:** påkrævet i Scrum, men de fleste Kanban-teams holder det. Scrum er **personorienteret**; Kanban ofte **board-orienteret** (flaskehalse), hvilket skalerer bedre
- **Burndown vs. CFD:** formålet er at vide **så tidligt som muligt**, om man er foran eller bagud

## Feedback loops
Kerne i empirisme: *ændr → se → lær → ændr igen*.
- Scrums loop er **sprinten** (uger): *"Are we building the right stuff?"*
- Med XP kommer flere, helt ned til **parprogrammering** (sekunder): *"Are we building the stuff right?"* ([[XP]])
- Kanban lægger **real-time metrics** oveni

## Eksamenspointer
- Kanbans eneste regler: **visualisér workflow** + **begræns WIP** (+ mål og optimér lead time)
- Scrum begrænser WIP **pr. tidsenhed**; Kanban **pr. workflow state**
- Default metric: Scrum = **velocity**, Kanban = **lead time**
- Begge er **empiriske**, **pull-baserede**, **lean og agile**
- Responstid: Scrum ≈ ½ sprint; Kanban = når der er kapacitet
- Fjerner du Scrums constraints, så kald det ikke Scrum
