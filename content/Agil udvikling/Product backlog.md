---
tags: [scrum, product-backlog, refinement, tech-stories, bugs, agil, systemudvikling]
kilder: ["Scrum Guide 2020", "Cohn kap. 15", "Kniberg: product backlogs, tech stories, bug tracking"]
---

# Product backlog

Del af [[Agil udvikling]]. Hvad der står i backloggen ([[User stories]]), og hvordan den holdes i praksis. Officielt er backloggen et af Scrums tre artefakter med **Product Goal** som commitment ([[Scrum#Artefakter og commitments]]).

## Definitionen

*(Scrum Guide)*

- En **emergent, ordnet liste** over det, der skal til for at forbedre produktet, og **den eneste kilde til arbejde**
- Items, der kan blive **Done** inden for én Sprint, er klar til udvælgelse ved Sprint Planning
- **Refinement** er en **løbende aktivitet**, hvor items nedbrydes og får detaljer (beskrivelse, rækkefølge, størrelse)
- **Developers estimerer størrelsen**; PO kan hjælpe med at forstå trade-offs
- **PO** er accountable for at ordne backloggen og sikre, at den er transparent og forstået

## Kun stories i backloggen

*(Cohn 15)*

I klassisk Scrum kan backloggen indeholde alt: features, tekniske opgaver, bugs. **Cohn begrænser den til user stories**, så hvert item beskriver værdi for en bruger eller PO:
- **PO kan prioritere**, fordi alt er i termer, PO forstår
- **Sprint planning går hurtigere**: ingen forklaring af teknologidrevne items
- **Sprint review** er lettere: alle items er brugerværdi
- **Daily scrum:** stories minder om **intentionen** og hjælper med at afgøre, om man er gået langt nok
- Fyld backloggen ved at finde **brugerroller** og skrive stories pr. rolle

### Iterativ vs. inkrementel

| Iterativ | Inkrementel |
|---|---|
| **Successiv forfinelse**: første version er bevidst ufuldstændig | Bygges **i stykker**, hvert stykke en **komplet** delmængde |
| Billedhuggeren hugger grundformen, så detaljer | Billedhuggeren gør næsen helt færdig, så øjnene |

**Scrum og XP er begge dele.** Scrum Guide kalder tilgangen *iterativ og inkrementel* ([[Scrum#Teori]]).

**Case, Cosmodemonic Biotech** (samme funktionalitet omskrevet): vandfald brugte 3.000 sider use cases og **540 personmåneder**; Scrum + 1.400 stories brugte **54 personmåneder** (840 vs. 120 linjer pr. personmåned).

---

## Backloggen i praksis

*(Kniberg)*

| Felt | Indhold |
|---|---|
| **ID** | Auto-nummer |
| **Name** | 2-10 ord, fx *"See your own transaction history"* |
| **Importance** | PO's tal; højt = vigtigt. Undgår ordet "prioritet" (hvad er vigtigere end prioritet 1?) |
| **Initial estimate** | Story points ([[Estimering og velocity]]) |
| **How to demo** | Simpel testspec: *"Gør dette, så dette, så skal dette ske"* |
| **Notes** | Afklaringer, referencer |

Ekstra felter efter behov: Track, Components, Requestor, Bug tracking ID.

> **🔄 2015:**
> - *"Backlog'en er Scrums hjerte"* → **nej**, et godt produkt starter med et **kundebehov og en vision**; backloggen er resultatet af at forfine visionen. Lad den vokse iterativt
> - **Intet importance-felt**: bare sortér listen
> - **Ingen mandage**: story points, T-shirt-størrelser eller ingen estimater
> - Online delt værktøj i stedet for Excel

### Hold backloggen på forretningsniveau
En teknisk PO skriver *"Add indexes to the Events table"*. Spørg **"men hvorfor?"**, indtil målet dukker op: *"speed up the search event form"*. Måske var indekset slet ikke flaskehalsen. **Teamet er bedst til *hvordan*.**

### Klar før sprint planning
*"Shit in = shit out."* Det kræver ikke perfekte stories, kun:
- Backloggen **findes**, med **én backlog og én PO** pr. produkt
- Vigtige items har **forskellige** importance-værdier (kun til sortering)
- PO **forstår hver story**: ikke nødvendigvis *hvad*, men *hvorfor*

**Rettigheder:** alle må tilføje stories; **kun PO** sætter importance; **kun teamet** sætter estimater.

🔄 2015: lav **backlog refinement i et separat møde** (fx 1 time om ugen), så sprint planning bliver kortere ([[Sprint planning]]).

---

## Tech stories

**Tech story** = noget, der skal laves, men ikke er leverbart og ikke har direkte værdi for PO: CI-server, systemdesign-overblik, refaktorering af DAO-laget. Behandles de som almindelige stories, nedprioriterer PO dem (*"tech candy bagefter"*).

**Knibergs trappe:**
1. **Undgå tech stories**: omformulér til målbar forretningsværdi (= Cohns linje og *Valuable* i [[User stories#Valuable]])
2. Lav det som **task i en anden story**
3. Ellers: en separat **tech backlog**, synlig for PO, men styret af teamet

**Dialogen der overbeviste PO:** estimeret velocity 80, faktisk 30, pga. manuelle releases. 10 % til en CI-server → mindst 20 % højere velocity fremover. PO: *"Hvorfor gjorde vi ikke det sidste sprint?!"* Team: *"Øh, fordi du ikke ville have det …"*

> **🔄 2015:** Små tech stories lægges i det daglige arbejde, store i en tech backlog. Aftal fx **10-20 % af tiden** og spørg på retroen, om det føltes rigtigt. Kan man ikke tale ærligt med PO om teknisk gæld, er der et **dybere tillidsproblem**.

Cohn kræver *kun* stories; Kniberg er pragmatisk og accepterer, at ikke alt kan omformuleres. Cohn viser samme greb for infrastruktur i [[Release planning#Infrastruktur og ikke-funktionelle krav]].

## Bugs

Fire strategier *(Kniberg)*:
1. PO hænger de vigtigste bugs op **blandt stories** (Knibergs favorit)
2. Stories, der refererer til bugs (*"fix de mest kritiske rapporteringsbugs: Jira-124, -126"*)
3. Bugfixing **uden for sprinten** med en lav focus factor
4. Hele backloggen i bugtrackeren

🔄 2015: ingen best practice; afhænger af konteksten. Cohn samler **små bugs** til én story ([[User stories#For små stories]]).
