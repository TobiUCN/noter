---
tags: [scrum, sprint-planning, sprint-goal, tasks, agil, systemudvikling]
kilder: ["Scrum Guide 2020", "Cohn kap. 9, 10, 15", "Kniberg: sprint planning, communicating sprints", "Beck kap. 7 (Weekly Cycle)"]
---

# Sprint planning

Del af [[Agil udvikling]]. Cohn kalder det **iteration planning**, Kniberg **sprint planning**, Beck **Weekly Cycle**: samme møde. [[Release planning]] gav en grov fordeling; nu planlægges **kun den iteration, der starter**.

## Definitionen

*(Scrum Guide)*

Planen laves af **hele Scrum Teamet**, timeboxet til maks. **8 timer** for en 1-måneds Sprint. Tre emner:
1. **Hvorfor er Sprinten værdifuld?** PO foreslår, hele teamet formulerer et **Sprint Goal**
2. **Hvad kan gøres færdigt?** Developers vælger items i dialog med PO. Kendskab til tidligere performance, kapacitet og DoD gør forecastet sikrere
3. **Hvordan?** Developers planlægger arbejdet, typisk ved at **nedbryde items i opgaver på én dag eller mindre**. *Hvordan* er **udelukkende Developers' beslutning**

**Sprint Goal + valgte items + planen = Sprint Backlog** ([[Scrum#Artefakter og commitments]]).

> **Formål i praksis** *(Kniberg)*: giv teamet nok information til at arbejde **uforstyrret i et par uger**, og giv PO nok tillid til at lade dem.

**Output** *(Kniberg)*: sprint goal · teammedlemmer (og engagement) · sprint backlog · dato for demo · tid og sted for daily scrum.

> **🔄 2015:** *"Det vigtigste event?"* Nej, **retrospektivet** er vigtigere, fordi det fikser alt det andet. Sprint planning er ret trivielt, når resten er på plads.

## Mødets forløb

| Cohn 10 (XP-stil) | Cohn 15 (Scrum, 2004) | Kniberg (13-17) |
|---|---|---|
| 1. Diskutér en story | **1. halvdel:** PO beskriver de vigtigste features | 13:00 PO: sprint goal + backlog. Demodato sættes |
| 2. Bryd den ned i tasks | **2. halvdel:** teamet beslutter alene, hvor meget de tager | 13:30 Estimering og nedbrydning; "how to demo" udfyldes |
| 3. En udvikler tager hver task | Sprint goal i fællesskab | 15:00 Teamet vælger stories; velocity som reality check |
| 4. Hver estimerer sine tasks → overbooket? | Items udvides til tasks | 16:00 Daily scrum-tid; videre nedbrydning |

**Beck** planlægger en **uge** ad gangen: gennemgå sidste uges fremdrift, lad kunden vælge en uges stories, bryd dem i tasks, som folk skriver sig på. Ugen starter med at **skrive de automatiserede tests**; målet er deploybar software fredag. **Planlægning er nødvendigt spild**: arbejd på at reducere den andel af tiden, det tager *(Beck 7)*.

🔄 2015: Kniberg-delen 13:30-15:00 **er backlog refinement**; flyt det til et separat møde ([[Product backlog]]).

## Hvorfor PO skal være med

*(Kniberg)*

```
        Scope  (PO)
        /    \
Importance —— Estimate
   (PO)        (teamet)
```

Estimering afslører scope-spørgsmål, svaret ændrer estimatet, som ændrer PO's prioritet. **Kun muligt ansigt til ansigt.** Nægter PO at deltage: forklar hvorfor → udpeg en **PO-proxy** med fuldt mandat → få ledelsen til at udpege en ny PO → **udskyd sprinten**.

## Timebox
*"Everything in Scrum is time-boxed."* Løber tiden ud, **skærer Kniberg mødet af**; teamet lærer, og næste møde bliver effektivt.

**Prioritering hvis tiden løber ud:** (1) sprint goal og demodato, (2) accepterede stories, (3) estimater, (4) "how to demo", (5) velocity som reality check (🔄 max 5 min), (6) tid og sted for daily scrum, (7) nedbrydning i tasks.

> **🔄 2015:** Max **1 time pr. sprintuge**. Et team "hadede Scrum", fordi deres sprint planning tog 2-3 dage. *"Giv ikke værktøjet skylden."*

## Sprintlængde

| Korte sprints | Lange sprints |
|---|---|
| Kort feedback, hyppigere levering | Momentum, plads til at komme sig over problemer, mindre overhead |
| **PO'er kan lide dem** | **Udviklere kan lide dem** |

- **Kniberg:** eksperimentér, og find så en længde, man **holder fast** i: en **"corporate heartbeat"**. Deres valg: 3 uger. 🔄 2015: næsten alle ender på 2-3 uger
- **Cohn 9:** 1-4 uger; hellere lidt for kort; hold den **konstant**. Bevidste afvigelser er OK, tilfældige ikke
- **Beck:** én uge, fordi alle er fokuserede på fredag *(Beck 7)*
- **Scrum Guide:** ≤ 1 måned

## Sprint goal

*(Kniberg)*
- *"Hellere et halvdårligt mål end intet."* I **forretningstermer**: "lav systemet godt nok til live beta"
- Svarer på *"hvorfor laver vi denne sprint, og hvorfor tager vi ikke bare alle på ferie?"*
- Virker fjollet ved planlægningen, men er guld **midt i sprinten**
- Ved review vurderes sprinten mod **sprint goal**, ikke mod hvert item *(Cohn 15)*
- 🔄 2015: et mål over flere sprints er også fint, bare sprinten er mere end "nak en bunke stories"

## Hvilke stories kommer med?

**Teamet bestemmer hvor mange**, ikke PO (begge bøger). Hvordan tallet findes: [[Estimering og velocity]].

**PO's tre håndtag**, hvis en vigtig story ikke kom med: **omprioritér**, **reducér scope** af en anden story, eller **split** en story.

**Scope under sprinten** *(Cohn 15)*:
- Når sprinten er startet, må **kun teamet** tilføje til sprint backlog (undtagen hvis teamet er foran og selv beder om mere)
- Til gengæld lover organisationen **ikke at ændre indholdet**. Sker noget vigtigt nok, **afbrydes** sprinten
- Product backlog må ændres **når som helst**
- *Cohn 10:* kunden ville skifte søgeløsning midt i en iteration; ved iterationens slutning sammenlignede hun en **fungerende** løsning med en, der ville tage 10 dage, og lod være

Det svarer til Scrum Guidens regel om, at scope kan genforhandles, men Sprint Goal ikke ændres.

## Definition of Ready og "how to demo"

**Det værste:** teamet demonstrerer stolt en feature, og PO siger *"pænt, men det var ikke det, jeg bad om."* Sørg for, at alle felter er udfyldt (🔄 2015: = **Definition of Ready**).

- *Estimatet afslører det:* "Add user" estimeres til 20 point → PO: *"Whaaat?!"* PO mente et SQL-script. Re-estimeret: 5
- *"How to demo" afslører det:* *"Først logger vi ind på websitet …"* → *"Websitet?!"*

"How to demo" er det typiske testscenarie i plain English (🔄 eller en wireframe/acceptkriterier). Definition of Done står i [[Test og kvalitet#Definition of Done i praksis]].

## Story-størrelse
- 0,5-point-stories → mikromanagement. 40-point-stories → risiko for at ende halvfærdig
- Mål: **2-8 mandage** pr. story. **Tommelfingerregel: 5-15 stories pr. sprint**
- Store stories kan næsten altid splittes ([[User stories#Opdeling af stories]])

## Nedbrydning i tasks

**Stories** er leverbare ting, PO bryder sig om; **tasks** er ikke-leverbare ting, PO er ligeglad med *(Kniberg)*.

**Hvorfor bryde ned, når stories allerede er små?** *(Cohn 10)*
1. Storyen laves ofte af **flere udviklere**
2. **Stories er ikke to-do-lister**: at bryde ned i fællesskab afslører glemte tasks
3. Det er **just-in-time design** og erstatter en up-front designfase

Kniberg tilføjer: mere realistisk plan, mere effektive daily scrums, og **afhængigheder** opdages tidligt (*"vi skal have hjælp fra Jim i HR"* → ring nu). Med TDD er første task næsten altid *"skriv en fejlende test"*.

*Cohns eksempel*, "en bruger kan søge efter hotel": kod basal søgeskærm · kod avanceret søgeskærm · kod resultatskærm · SQL til basal · SQL til avanceret · **dokumentér i hjælpesystemet** (stod ikke i storyen).

**Opdeling:** skil dele ud, der er **svære at estimere**, kan laves af **forskellige udviklere**, eller hvor det er **nyttigt at vide, at de er færdige**.

**Ansvar** *(Cohn 10)*: **én person** skriver sit navn på hver task, men **alle har ansvaret**. Hver estimerer sine tasks; 53 timer på en 2-ugers iteration er urealistisk → giv tasks væk eller tal med kunden om at droppe en story.

**Index cards frem for projektor** *(Kniberg)*: folk står op og er involverede, flere stories redigeres samtidig, og kortene kan flyttes direkte til **task boardet** ([[Under sprinten]]).

## Daily scrum: tid og sted
Den første daily scrum er reelt **kickoff**. Morgen: man skal huske hvad man **lavede**; eftermiddag: hvad man **lovede**. Kniberg vælger det tidligste tidspunkt, hvor ingen stønner. 🔄 2015: lad teamet bestemme.

## Kommunikér sprinten

*(Kniberg)*
**Sprint info page** på wiki'en (goal, backlog, velocity, datoer, teammedlemmer), mail til firmaet, dashboard over alle sprints, og en udprint uden for teamrummet.

## Ansvar

*(Cohn 10)*

| Udvikleren | Kunden |
|---|---|
| Hjælpe med at bryde **alle** stories ned | Prioritere stories til iterationen |
| Tage en **passende mængde** arbejde | Styre mod **størst forretningsværdi** |
| Følge med i kollegers arbejde; tag over, hvis du bliver færdig først | |

**Øvelse 10.1:** Bryd ned i tasks: *"En bruger kan se detaljeret information om et hotel."*
