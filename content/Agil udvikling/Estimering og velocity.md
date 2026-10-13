---
tags: [scrum, estimering, velocity, story-points, planning-poker, agil, systemudvikling]
kilder: ["Cohn kap. 8", "Kniberg: estimating, planning poker, days vs. hours"]
---

# Estimering og velocity

Del af [[Agil udvikling]]. Cohn giver **teorien**, Kniberg **praksis**, og 🔄 2015-Kniberg skærer det meste af praksissen væk igen. Tallene bruges i [[Release planning]] og [[Sprint planning]].

## Hvad en estimeringsmetode skal kunne

*(Cohn 8)*
Lade os **ændre mening** · virke for **epics og små stories** · **ikke tage lang tid** · give info om **fremskridt** · **tåle upræcise estimater** · kunne bruges til **releaseplanlægning**. Svaret er **story points**.

## Story points

- **Hvert team definerer selv**, hvad et point er: en ideel dag, en ideel uge eller kompleksitet (Kerievsky: *Nebulous Units of Time*)
- **Cohn foretrækker 1 point = 1 ideel dag** (ingen møder eller afbrydelser): lettere end kalendertid og gør omregning til tid lettere
- **Kniberg (2007):** point ≈ ideelle mandage. *"Hvis I låser jer inde med masser af mad og arbejder uforstyrret, hvor mange dage før I har noget færdigt, testet og releasebart?"* 3 personer × 4 dage = **12 point**
- **Begge:** det er de **relative** estimater, der tæller

> **🔄 2015:** Ingen mandage. Story points, T-shirt-størrelser eller **slet ingen estimater** (tæl stories). Kald dem **størrelses-estimater**: *"'banana' er lidt større end 'apple' og meget mindre end 'orange'. Better to be roughly right than precisely wrong."*

## Hvem estimerer? Teamet

| Hvad | Ejes af | Hvorfor |
|---|---|---|
| **Story-estimater** | **Teamet** kollektivt | Man ved ikke, hvem der laver storyen; teamestimater er bedre |
| **Task-estimater** | **Den enkelte**, der har taget tasken | Se [[Sprint planning#Nedbrydning i tasks]] |

Alle skal estimere alle stories *(Kniberg)*: stories involverer flere fagligheder, alle skal forstå dem (så de kan hjælpe hinanden), og uenigheder opdages **tidligt**. **Kunden/PO** svarer på spørgsmål, men **estimerer ikke** og kommenterer ikke estimater *(Cohn)*.

## Planning poker (Wideband Delphi)

Cohns metode bygger på **Wideband Delphi** (Boehm 1981); Kniberg kalder det **planning poker**.

1. Kunden **læser en story** op
2. Udviklerne **spørger**, til den er forstået
3. Alle **vælger et estimat skjult**
4. **Vend samtidig**, så ingen læner sig op ad den, der forstår storyen bedst
5. **Højeste og laveste forklarer**: ikke som angreb, men for at lære
6. Kort diskussion
7. **Estimér igen**, sjældent mere end **3 runder**

- **Rimelighed frem for præcision:** 4, 4, 4 og 3 → spørg den lave, om 4 er OK
- **"Everything takes four hours":** estimatet skal inkludere **alt**: test, snak med kunden, acceptancetests
- **Estimér hele storyen**, ikke kun din del

### Skalaen er ikke-lineær

| Cohn | ½, 1, 2, 3, 5, 8, 13, 20, 40, 80 |
|---|---|
| **Kniberg** | 0, ½, 1, 2, 3, 5, 8, 13, 20, 40, 100, **?**, **☕** |

- **Præcision falder med størrelsen:** 2 vs. 3 er værd at diskutere; 7 vs. 8 implicerer præcision, vi ikke har. Vil man have præcision, **split storyen**
- **0** = allerede lavet, **?** = aner det ikke, **☕** = pause. (🔄 "No Bullshit"-spillet: **1**, **TFB**, **NFC**)

**Triangulering** *(Cohn)*: sammenlign nye estimater med eksisterende (er 4-pointeren dobbelt så stor som 2-pointeren?), så betydningen af et point ikke glider.

---

## Velocity

**Velocity = antal story points teamet færdiggør pr. iteration.** Det er velocity, der oversætter point til tid.

### Hvorfor upræcise estimater ikke gør noget

*(Cohn)*
Projekt på 300 point, forventet 30/uge. Første iteration giver **50** → regn med 50, hvis intet usædvanligt skete, estimaterne er **konsistente**, og storyerne var **uafhængige**.

**Central Limit Theorem:** summen af uafhængige stikprøver er tilnærmelsesvis normalfordelt, så selv systematisk over- eller underestimering korrigeres af velocity. Dårligere med få store stories.

- **Parprogrammering påvirker velocity, ikke estimater:** samme fart, forskellen opfanges i velocity
- Dit teams point ≠ mit teams point
- Splittes en epic, behøver summen af de nye estimater **ikke** være lig epicens

### Sådan beregnes velocity

*(Kniberg)*
- **Faktisk velocity = summen af de *oprindelige* estimater for stories, der blev *helt* færdige**
- **Ingen halve point.** Halvfærdigt har værdien nul

| Teknik til forventet velocity | Hvordan |
|---|---|
| **Gut feel** | "Kan vi nå A? A+B? … +E? Nærmere 50 %" → tag A-D |
| **Yesterday's weather** | Samme velocity som de seneste sprints |
| **Ressourceberegning** | Tilgængelige mandage × **focus factor** |

**Focus factor:** 18 point på 45 mandage = 40 %. Næste sprint 50 mandage × 40 % = **20 point**. Er du i tvivl, tag færre. Default for nye teams: **70 %**.

> **🔄 2015 — "the part I really hate":** drop focus factor. Den giver **falsk præcision**, tvinger estimater i mandage, antager at **flere folk = højere velocity** (nye folk sænker den), og ordet antyder, at teamet er "ufokuseret". **I stedet:** se hvad I fik lavet de sidste sprints, og tag cirka så meget.

**Til sidst altid et gut feel-tjek:** føles det realistisk?

### Dage vs. timer for tasks
Kniberg skiftede fra timer til **dage** (min. 0,5), fordi timer gav **mikromanagement**. 🔄 2015: **drop task-estimater**; lav tasks på ca. én dag, og tæl tasks, hvis man vil have burndown.

## Ansvar

*(Cohn)*

| Udvikleren | Kunden |
|---|---|
| Definere story points og **holde fast** i definitionen | Deltage for at **svare og afklare** |
| Give **ærlige** estimater; ikke give efter for pres | **Ikke** estimere selv |
| Estimere **som team**, konsistent | |

**Øvelse:** Team A og Team B (dobbelt så mange udviklere) laver begge 43 point på to uger. Hvordan? (Point er teamspecifikke.)
