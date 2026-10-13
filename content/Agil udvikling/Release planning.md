---
tags: [scrum, release-planning, prioritering, moscow, agil, systemudvikling]
kilder: ["Cohn kap. 9", "Kniberg: release planning and fixed-price contracts", "Beck kap. 7 (Quarterly Cycle)"]
---

# Release planning

Del af [[Agil udvikling]]. Planlægning **mere end én sprint frem**: *"hvornår, senest, kan vi levere version 1.0?"* Bygger på [[Estimering og velocity]]. Kniberg anbefaler selv Cohns bøger frem for sit eget kapitel.

```
1. Hvornår vil vi have releasen?          (dato eller datointerval)
2. Hvad skal med, i hvilken rækkefølge?   (kunden/PO prioriterer)
3. Hvor store er stories?                 (teamet estimerer)
4. Hvor hurtigt kører vi?                 (velocity)
5. Fyld iterationer op til velocity       → releaseplan
6. Revidér efter hver iteration
```

## 1. Hvornår?

*(Cohn)*
- Typisk ny release hver **2-6 måneder**, gerne ud fra en **roadmap med temaer**. Becks **Quarterly Cycle** gør det samme: planlæg et kvartal ad gangen med temaer og stories, find flaskehalse og se det store billede *(Beck 7)*
- **Datointerval frem for fast dato:** iterativ udvikling gør det let at fastlåse en **dato**, men svært at fastlåse **indholdet**
- **Fast dato** (messe) gør planlægningen lettere, men valget af indhold sværere

## 2. Prioritering

### MoSCoW (fra DSDM)

*(Cohn)*

| | Betydning |
|---|---|
| **M**ust have | Fundamentalt |
| **S**hould have | Vigtigt, men der findes en workaround |
| **C**ould have | Kan droppes, hvis tiden løber ud |
| **W**on't have this time | Kommer i en senere release |

Undgår diskussioner om "high" vs. "medium", **men** kunden skal i sidste ende sortere i **præcis rækkefølge**.

### Acceptance thresholds

*(Kniberg, fastpriskontrakter)*

| Importance | Betydning | ≈ MoSCoW |
|---|---|---|
| ≥ 100 | **Skal** med i 1.0, ellers bøder | Must |
| 50-99 | **Bør** med | Should |
| 25-49 | Kan komme i 1.1 | Could |
| < 25 | Spekulativt | Won't |

Farvekod backloggen rød/gul/grøn. (🔄 2015: virker lige så godt uden tal.)

### Hvad prioriteres efter?

*(Cohn)*

| Teknisk | Kunde/bruger |
|---|---|
| **Risiko** for at storyen ikke kan laves | Ønsket af en **bred** kundebase |
| **Påvirkning af andre stories** | Ønsket af **få, vigtige** kunder |
| | **Sammenhæng** med andre stories |

> **Når udviklere og kunde er uenige om rækkefølgen, vinder kunden. Hver gang.**

Kunden kan ikke prioritere uden **estimater**, så der estimeres *før* prioritering, og værdi vejes mod pris. **Pris ændrer prioritet:** Enter i stedet for Tab kostede en ekstra personuge, og så faldt prioriteten. **Blandede prioriteter → split** (søgning på forfatter/titel er essentiel, resten nice-to-have).

### Risiko vs. "the juicy bits"

| Boehm (spiralmodellen) | Gilb |
|---|---|
| Eliminér **risiko** først | Tag de **saftige stykker** (højeste værdi) først |

**Agile står i Gilb-lejren**, men risiko indgår stadig, og beslutningen er **kundens**.

### Infrastruktur og ikke-funktionelle krav
- *"Generér 50 aktiekursgrafer pr. sekund"* har enorm betydning for arkitekturen, men kunden prioriterede den lavt. Nogle gange er det let at refaktorere til skalerbarhed, andre gange meget svært
- **Udviklernes ansvar:** peg på stories, der bliver **meget dyrere senere**, men brug det ikke til at styre kunden mod yndlingsteknologi
- *3-lags-eksemplet:* ingen story krævede mellemlaget → skriv det som brugerværdi: *"Under installationen kan brugeren vælge at installere klient, mellemlag og server separat."* Samme greb som tech stories ([[Product backlog#Tech stories]])

## 3-4. Fra point til varighed

**Varighed = samlet antal point / velocity.** 100 point / 25 = **4 iterationer**.

| Startvelocity *(Cohn)* | Vurdering |
|---|---|
| **1. Historiske tal** | Bedst, men kræver samme team og lignende projekt |
| **2. Kør én iteration** og mål | Godt, men ofte ikke muligt |
| **3. Gæt** | Med 1 point = 1 ideel dag: **⅓-½ af udviklerdagene**. 6 × 10 dage → **20-30 point** |

Kniberg (2007): 6 personer × 15 dage × focus factor 50 % = **45 point**. 🔄 2015: lad i stedet teamet give et kvalificeret gæt.

## 5. Lav planen
Tag stories ovenfra og fyld hver iteration op til velocity. *Kniberg:* alle must + should på 3 sprints = 9 uger → han lover 3 måneder (buffer). Cohn: udviklerne skal levere realistiske estimater **og passende projektbuffer**.

> **🔄 2015 — bedre:** estimér velocity som et **interval** (fx 30-50) og del backloggen i **All** (laves selv ved lav velocity), **Some** og **None**.

Kommunikér planen efter formalitetsbehov: kort på væggen, regneark, eller en triviel Gantt til høj-ceremoni-interessenter.

## 6. Tilpas planen

> ⚠️ Planen giver præcision til **"klar om ca. 5-7 iterationer"**, ikke til **"vi er færdige 3. juni"** *(Cohn)*.

- Følg velocity og genkalibrér løbende
- *"Reality will not adapt itself to a plan, so it must be the other way around"* *(Kniberg)*. Er man bagud, forhandler PO scope: *"vi når deadline, hvis vi dropper Pac-Man"*. Kunden får et **tidligt, ærligt valg**
- 🔄 2015: læs **Lean Startup**: lever små inkrementer og mål, i stedet for en big-bang release

## Ansvar

*(Cohn)*

| Udvikleren | Kunden |
|---|---|
| Give information om antagelser og alternativer | Prioritere i **præcis rækkefølge** |
| **Modstå trangen** til at prioritere infrastruktur for højt | Give **ærlige deadlines** |
| Plan med realistiske estimater **og buffer** | Forstå forskellen på **ideel tid og kalendertid** |
| | **Splitte** stories med forskellig prioritet |

**Øvelse 9.2:** 4 udviklere, 27 point, velocity 4 → 27/4 = 6,75 → **7 iterationer**. Antallet af udviklere er irrelevant; det ligger i velocity.
