---
tags: [scrum, skalering, scrum-of-scrums, feature-teams, distribuerede-teams, agil, systemudvikling]
kilder: ["Kniberg: multiple Scrum teams, geographically distributed teams", "Scrum Guide 2020", "Beck kap. 7 (Whole Team)"]
---

# Skalering af Scrum

Del af [[Agil udvikling]]. Primært Kniberg. *"Flere udviklere = flere komplikationer"*: det er universelt og har intet med Scrum at gøre. Scrum Guide siger kun, at teams, der bliver for store, deles i flere teams med **samme Product Goal, Product Backlog og PO** ([[Scrum#Scrum Teamet]]).

Nøglespørgsmålene: **hvor mange teams?** · **hvem i hvilke?** · **hvordan holdes de i sync?**

## Hvor mange teams?

- Kniberg havde et team på **~11**: daily scrum over 15 min, folk vidste ikke, hvad de andre lavede
- Split kun, hvis teamet er erfarent, roadmappen kan deles i to spor, og sporene ikke rører samme kode

> **Hellere færre teams, der er for store, end mange små, der forstyrrer hinanden.**

**Virtuelle teams** er tegn på forkert opdeling: se, **hvem der taler med hvem**. Deler et team sig permanent i to, så split det; taler to teams hele tiden sammen, så slå dem sammen. 🔄 2015: **super-teams** på 12-16, der deler én backlog og klumper sig om stories.

**Optimal størrelse:** Kniberg siger **3-8**; Scrum Guide ≤ 10; Beck peger på **12** som tærsklen for, hvor mange der kan interagere komfortabelt ([[XP#Whole Team]]).

> **🔄 2015:** Kæmper man med teamstrukturen, er synderen ofte **arkitekturen**. Udvikl arkitektur og teamstruktur sammen.

## Synkroniserede sprints?
Kniberg startede med **forskudte** sprints, men Ken Schwaber overbeviste ham om at **synkronisere**: naturligt tidspunkt at omrokere teams, fælles mål og planlægning, mindre administration. 🔄 2015: Spotify lader nu hvert team vælge rytme, men har daglig sync og **ugentlig demo af det integrerede produkt**.

## Hvem fordeler folk?
Ikke PO. Kniberg indførte en **team lead** ("scrum-of-scrums master"). 🔄 2015: oftest linjelederen, og de bedste hjælper teamet med at **selvorganisere** sig i en struktur.

**Kombinationen virker bedst:** (1) team lead, PO og SM'er laver en **foreløbig** fordeling, (2) ved sprint planning: *"gå sammen og tag en vægsektion"*, (3) *"fordelingen er foreløbig, brug sund fornuft"*. **Centraliseret kontrol først, decentral optimering bagefter.**

## Feature-teams frem for komponent-teams

| Komponent-teams | Feature-teams ✅ |
|---|---|
| Client-, server- og DB-team | Hvert team laver en **hel story** gennem alle lag |
| *"Vi venter på server-folkene"* | Teams arbejder **uafhængigt** |

🔄 2015: testspørgsmålet til et team: **"Hvem er vores kunde, og kan vi opfylde deres behov uden at blokere på andre teams?"** Undtagelse: platform-teams, der behandler feature-teams som kunder. Det er Cohns **"slice the cake"** på organisationsniveau ([[User stories#Split gennem lagene ("slice the cake")|User stories]]).

## Omrokering og deltid
- **"Team gel"** tager nogle sprints. Kortsigtede ændringer → lad være; langsigtede → gør det. 🔄 2015: uændret medlemskab i **mindst et kvartal**; ændringer indefra forstyrrer mindre
- **Deltidsmedlemmer** er generelt en dårlig idé (🔄 *"it usually totally sucks!"*). *"Hellere tre fuldtidsfolk end otte på deltid."* Under 50 % = ikke teammedlem. Beck kalder det **brøkdels-mennesker**

## Scrum-of-scrums

| Produktniveau | Firmaniveau |
|---|---|
| SM'erne mødes ugentligt: hvad lavede vores team, hvad laver det nu, forhindringer, tværgående emner | Erstattet af et ugentligt **all-hands på 15 min** |

🔄 2015: Spotify kører **daily sync** med fokus på **afhængigheder**, ikke status. Mødet er en **markedsplads**. *"Don't be a Scrum zombie!"*

**Interleaving af daily scrums**, så PO kan nå alle. 🔄 2015: daily scrum er **til teamet**; påtving det ikke.

**Brandslukningsteams:** et Scrum-team stabiliserer systemet, mens et "support"-team slukker brande og beskytter dem. 🔄 2015: brug kanban til brandslukning, men **kun midlertidigt**; normalt en **roterende brandmandsrolle**.

## Én backlog eller flere?

| Strategi | Vurdering |
|---|---|
| **1. Én PO, én backlog** | ✅ Foretrukket. Teams trækker stories fra én backlog-væg. 🔄 Indbygget i **SAFe** |
| 2. Én PO, flere backlogs | Fallback; PO bliver flaskehals |
| 3. Flere PO'er, hver sin backlog | Kniberg: "gør vi nok aldrig". 🔄 **Spotify gør det** (70+ teams), men det kræver en afkoblet arkitektur |

## Code branching
Hold **trunk konsistent** (alt kompilerer, tests består), **tag hver release**, **branch kun når nødvendigt**, brug branches til at **adskille livscyklusser**, og **synkronisér ofte**. 🔄 2015 med Git: commit ofte, kortlivede branches. Teknisk understøttes det af CI ([[XP#Continuous Integration]]).

## Multi-team retrospektiver
🔄 2015: hvert team holder retro; efter en time mødes alle, og hvert team fremlægger hovedpointer + **største uløste forhindring**. Ofte er én tydeligt den største på tværs.

> **🔄 2015 — "Context is king".** Fællesnævnerne: **tværfunktionelle teams, visualisering, hyppig levering, rigtige brugere, automatiseret test og release, masser af eksperimenter.**

## Geografisk distribuerede teams
**Maksimér kommunikationsbåndbredden**: parprogrammering, daily scrum ansigt til ansigt, socialt samvær, fælles information radiators. Tiltag: webcam og headset, fjernklar mødelokaler, **"remote windows"**, udvekslingsprogrammer.

🔄 2015: open source viser, at distribueret kan lykkes, men **intet slår et lille tværfunktionelt team i samme rum**. Beck: distribuerede teams kan lave XP, og "Sit Together" er en forudsigelse om, at mere ansigtstid hjælper.

**Offshoring:** Kniberg startede med **separerede teammedlemmer** (ét team på tværs af lande) for at lære hinanden at kende, og bevægede sig mod **separerede teams** på sigt. 🔄 2015: et distribueret team opnår aldrig samme *"teaminess"*.

**Hjemmearbejde:** **teamet bestemmer selv**. 🔄 2015: *når teamet er tydeligt ansvarligt for produktet, opfører det sig ansvarligt.*
