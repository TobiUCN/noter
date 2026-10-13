---
tags: [scrum, agil, systemudvikling, eksamen]
kilder: ["Scrum Guide 2020"]
---

# Scrum

Del af [[Agil udvikling]]. Definitionen fra **Scrum Guide 2020** (Schwaber & Sutherland). Hvordan det bruges i praksis står i [[Sprint planning]], [[Under sprinten]] og [[Product backlog]].

> Scrum er et **letvægts framework**, der hjælper mennesker, teams og organisationer med at skabe værdi gennem *adaptive løsninger på komplekse problemer*.

**I en nøddeskal:** Scrum Master skaber et miljø, hvor (1) en **Product Owner** ordner arbejdet i et **Product Backlog**, (2) **Scrum Teamet** omsætter et udvalg til et **Increment** i løbet af en **Sprint**, (3) teamet og **stakeholders** inspicerer resultatet og tilpasser, og (4) gentag.

| 3 accountabilities | 5 events | 3 artefakter | 3 commitments |
|---|---|---|---|
| Product Owner | Sprint (container) | Product Backlog | Product Goal |
| Scrum Master | Sprint Planning | Sprint Backlog | Sprint Goal |
| Developers | Daily Scrum | Increment | Definition of Done |
| | Sprint Review | | |
| | Sprint Retrospective | | |

### Vigtige pointer
- Frameworket er **bevidst ufuldstændigt**: det definerer kun det nødvendige; resten fylder teamet ud
- Scrum er **immutable**: man kan implementere dele, men *resultatet er så ikke Scrum*. At udelade elementer skjuler problemer
- Scrum "wrapper" om eksisterende praksisser og synliggør, hvor effektive de er
- "Developers" bruges bredt: analytikere, testere osv.

## Teori

- **Empirisme:** viden kommer af erfaring; beslutninger træffes ud fra det observerede
- **Lean thinking:** reducér spild, fokusér på det væsentlige
- Derfor en **iterativ og inkrementel** tilgang, der optimerer forudsigelighed og kontrollerer risiko

### De tre empiriske pilarer

| Pilar | Indhold |
|---|---|
| **Transparency** | Proces og arbejde skal være synligt. Lav transparens → beslutninger, der mindsker værdi og øger risiko. *Inspection uden transparency er vildledende* |
| **Inspection** | Artefakter og fremdrift inspiceres **hyppigt**. Events giver kadencen. *Inspection uden adaptation er formålsløs* |
| **Adaptation** | Afviger noget, justeres det **så hurtigt som muligt**. Svært, hvis folk ikke er empowered eller self-managing |

> **Transparency → Inspection → Adaptation**: hver er værdiløs uden den næste.

### De fem værdier

| Værdi | I praksis |
|---|---|
| **Commitment** | Forpligt jer på målene og på at støtte hinanden |
| **Focus** | Fokus på arbejdet i Sprinten |
| **Openness** | Åbenhed om arbejdet og udfordringerne |
| **Respect** | Respektér hinanden som kompetente, selvstændige mennesker |
| **Courage** | Mod til at gøre det rigtige og tage fat på svære problemer |

Når værdierne leves, kommer pilarerne til live, og der opbygges tillid.

---

## Scrum Teamet

**1 Scrum Master + 1 Product Owner + Developers.** Ingen sub-teams eller hierarkier; ét mål ad gangen: **Product Goal**.

- **Cross-functional:** tilsammen alle nødvendige kompetencer
- **Self-managing:** bestemmer selv hvem, hvad, hvornår og hvordan
- **Typisk 10 eller færre.** Bliver det for stort, opdeles det i flere teams med **samme Product Goal, Product Backlog og Product Owner** ([[Skalering af Scrum]])
- Ansvarligt for alle produktrelaterede aktiviteter, i et **bæredygtigt tempo**

> Ændring fra 2017-guiden: der er ikke længere et "Development Team" inde i Scrum Teamet, og man taler om **accountabilities** frem for roller.

| Accountability | Ansvarlig for |
|---|---|
| **Developers** | **Sprint Backlog**, at overholde **Definition of Done**, at tilpasse planen dagligt mod **Sprint Goal**, at holde hinanden ansvarlige |
| **Product Owner** | At **maksimere værdien**: udvikle og kommunikere **Product Goal**, skabe og ordne backlog items, sikre at backloggen er transparent og forstået |
| **Scrum Master** | At **etablere Scrum** og teamets **effektivitet**. En ægte leder, der tjener (servant leadership) |

**Product Owner:** **én person, ikke et udvalg**. Må delegere, men forbliver accountable. Organisationen skal respektere PO'ens beslutninger. **Kun PO kan aflyse en Sprint.**

**Scrum Master tjener:**
- **Teamet:** coacher i self-management, får fjernet **impediments**, sikrer at events holdes inden for timeboxen
- **Product Owner:** teknikker til Product Goal og backlog management, empirisk planlægning
- **Organisationen:** leder og coacher Scrum-adoptionen, fjerner barrierer mellem stakeholders og teams

---

## Events

**Sprinten er containeren for alle andre events.** Hvert event er en formel mulighed for inspection og adaptation; udelades et, mistes den mulighed. Afhold dem samme tid og sted.

| Event | Timebox (1-måneds Sprint) | Formål | Detaljer |
|---|---|---|---|
| **Sprint** | ≤ 1 måned, fast længde | Container; ideer bliver til værdi | Nedenfor |
| **Sprint Planning** | maks. **8 t** | Læg planen for Sprinten | [[Sprint planning]] |
| **Daily Scrum** | **15 min** | Inspicér fremdrift mod Sprint Goal | [[Under sprinten#Daily scrum]] |
| **Sprint Review** | maks. **4 t** | Inspicér udfaldet, afgør næste skridt | [[Under sprinten#Sprint review]] |
| **Sprint Retrospective** | maks. **3 t** | Øg kvalitet og effektivitet | [[Under sprinten#Retrospektiv]] |

Kortere Sprints giver typisk kortere events.

### The Sprint
> *"Sprints are the heartbeat of Scrum, where ideas are turned into value."*

- **Én måned eller mindre**, fast længde. En ny starter umiddelbart efter den forrige
- **Under Sprinten:** ingen ændringer, der bringer Sprint Goal i fare; kvaliteten falder ikke; backloggen refines efter behov; scope kan præciseres og genforhandles med PO
- Kortere Sprints = flere læringscyklusser og mindre risiko
- Burn-down og lignende er nyttige, men **erstatter ikke empirisme**
- En Sprint kan **aflyses**, hvis Sprint Goal bliver forældet, **kun af PO**

---

## Artefakter og commitments

Artefakter **repræsenterer arbejde eller værdi** og maksimerer transparens. Hvert har et **commitment**, som fremdrift kan måles mod:

| Artefakt | Commitment | Kort |
|---|---|---|
| **Product Backlog** | **Product Goal** | Det langsigtede mål |
| **Sprint Backlog** | **Sprint Goal** | Det ene mål for Sprinten |
| **Increment** | **Definition of Done** | Kvalitetsmålestokken |

### Product Backlog → Product Goal
En **emergent, ordnet liste** over det, der skal til for at forbedre produktet, og **den eneste kilde til arbejde**. Refinement, estimering og praksis står i [[Product backlog]].

**Product Goal** beskriver en **fremtidig tilstand af produktet**. Det ligger i backloggen, og ét mål skal **opfyldes eller opgives**, før man tager det næste.

### Sprint Backlog → Sprint Goal
Tre dele: **Sprint Goal** (*hvorfor*), **valgte items** (*hvad*) og **en handlingsorienteret plan** (*hvordan*). En plan **af og for Developers**, synlig i realtid og opdateret løbende.

**Sprint Goal** er Sprintens **ene** mål. Det skaber fokus og giver fleksibilitet: viser arbejdet sig anderledes end forventet, forhandles scope med PO, **uden at ændre Sprint Goal**.

### Increment → Definition of Done
- Et **konkret trædesten** mod Product Goal, **additivt** og grundigt verificeret, og **usable**
- Der kan laves **flere Increments i én Sprint**, og de må leveres **før** Sprintens afslutning. **Sprint Review er aldrig en "gate"**
- Arbejde tæller **kun**, hvis det opfylder Definition of Done

**Definition of Done** er en formel beskrivelse af den kvalitet, et Increment skal have. Når et item opfylder DoD, er **et Increment født**. Opfylder det ikke DoD, kan det hverken releases eller præsenteres; det går tilbage i backloggen. Er DoD en organisatorisk standard, følger alle teams den som minimum; flere teams på samme produkt skal have **samme DoD**. Hvordan teams laver en DoD i praksis står i [[Test og kvalitet#Definition of Done i praksis]].
