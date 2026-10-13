---
tags: [xp, agil, systemudvikling, værdier, praksis, tdd, parprogrammering, ci, eksamen]
kilder: ["Beck: XP Explained 2. udg., kap. 3, 4, 6, 7", "Kniberg: How we combine Scrum with XP (s. 103-112)"]
---

# XP (Extreme Programming)

Del af [[Agil udvikling]]. Beck giver *idealet*, Kniberg *hvad der skete, da et team prøvede* (markeret **Fra praksis**). XP supplerer Scrum med de tekniske praksisser, Scrum bevidst udelader ([[Agil udvikling#Scrum og XP er komplementære]]).

## Værdier, principper og praksisser

*(Beck 3)*

| Niveau | Hvad | Kendetegn |
|---|---|---|
| **Practices** | Det du gør dag til dag | **Klart og objektivt**: enten skrev du testen først, eller også ikke |
| **Principles** | Domænespecifikke retningslinjer | **Broen** mellem værdier og praksis |
| **Values** | Rødderne til, hvad du kan lide og ikke lide | **Universelle** |

*Gartner-analogien:* at plante morgenfruer ved jordbær er en **praksis**; *companion planting* er **princippet**.

- **Værdier uden praksis** er uforpligtende: *"Jeg skrev det tusind sider lange dokument, fordi jeg værdsætter kommunikation."* En kvarters samtale om dagen havde kommunikeret bedre
- **Praksis uden værdier** bliver **rote**. Parprogrammering *for at* kommunikere og fange fejl giver mening; som noget der skal krydses af, gør den ikke

> **Values bring purpose to practices. Practices bring accountability to values.**

**Værdier er universelle, praksisser er situationsbestemte:** feedback er den samme værdi, men "byg og test kontinuerligt" er absurd, når man skifter ble. Skifter situationen, skifter praksisserne. Og ingen bog gør dig til gartner: man lærer ved at gøre det.

## De fem værdier

*(Beck 4)*

Det, der betyder noget, er, hvordan individerne opfører sig **som team**. Kodestil er vigtig, men det vigtigste er, at teamet har en *fælles* stil.

| Værdi | Kernen |
|---|---|
| **Communication** | Når problemer opstår, kender nogen ofte allerede løsningen; den når bare ikke frem. Spørg ved ethvert problem: skyldtes det manglende kommunikation? **Bevægelse uden kommunikation er ikke fremdrift** |
| **Simplicity** | Den **mest krævende**. *"What is the simplest thing that could possibly work?"*: kritikere overser **anden halvdel**. Simpelt giver kun mening i kontekst (parser-generator vs. recursive descent) |
| **Feedback** | **Ingen fast retning holder længe.** Man kan ikke "gøre det rigtigt første gang", fordi man ikke ved hvordan, fordi det ændrer sig, og fordi det tager for lang tid. Få feedback i minutter og timer. **Man kan få for meget**: sæt så farten ned |
| **Courage** | Effektiv handling i mødet med frygt: **bias to action** *og* **tålmodighed**. ⚠️ Mod alene er farligt; det skal styres af de andre værdier |
| **Respect** | Ligger **under** de fire andre. *"I am important and so are you."* |

Værdierne støtter hinanden: bedre kommunikation → simplere system; simplere system → lettere at få feedback på. Andre værdier (safety, predictability) er mulige; det vigtigste er, at **adfærd flugter med værdier**.

---

## Sådan skal praksisserne læses

*(Beck 6)*

- **Ufrugtbare i sig selv** uden værdierne
- **Formuleret som absolutter**, men er en **vektor**: deployer I én gang om året, er "oftere end i går" forbedringen
- **Et valg** og en **hypotese**: "lad os prøve og se, om det hjælper"
- **De forstærker hinanden**

| | Primary practices (kap. 7) | Corollary practices (kap. 9) |
|---|---|---|
| Uafhængighed | Nyttige **uafhængigt** | Svære **uden** primary |
| Risiko | **Trygt at starte** med hvilken som helst | Start ikke her |

---

## De 13 primary practices

*(Beck 7)*

### Sit Together
**Udvikl i et åbent rum til hele teamet**, med små private rum i nærheden. Becks Chicago-historie: projektet sejlede, fordi seniorerne sad i hvert sit hjørnekontor; da de flyttede sammen, kørte det.
1. **Uanset hvad kunden siger, er problemet altid et menneskeproblem**
2. Det betyder meget at kommunikere **med alle sanser**

⚠️ Riv ikke væggene ned, før teamet er klart. Distribuerede teams kan lave XP; praksissen er en **forudsigelse** om, at mere ansigtstid hjælper. Kniberg siger det samme: *"Seat the team together!"* ([[Under sprinten#Teamrummet]])

### Whole Team
**Alle de kompetencer og perspektiver, projektet kræver.** *We belong. We are in this together. We support each other.*
- Dynamisk: hent kompetencer ind efter behov
- **12 og 150** er tærskler for tillid (*The Tipping Point*); større projekter bliver et **team af teams**
- ⚠️ **Brøkdels-mennesker** (40 % her, 60 % der) er antimønstret

Overlapper med Scrums cross-functional team ([[Scrum#Scrum Teamet]]); Kniberg bruger Scrum-udgaven.

### Informative Workspace
En iagttager skal kunne se, hvordan projektet går, på **15 sekunder**. Story-kort på væggen, store synlige diagrammer (tag dem ned, når de ikke opdateres), vand og snacks.

> **Fra praksis:** væggene er tapetseret med information. Det største problem er **gammelt skrammel**.

### Energized Work
**Arbejd kun så mange timer, som du er produktiv i og kan holde til.** Hvor er beviset for, at 80-timers uger giver mere værdi end 40? Lange dage er en måde at gribe kontrol, når man ellers ikke har den. Bliv hjemme, når du er syg. Start evt. med to timers **Code Time** om dagen.

> **Fra praksis ("sustainable pace"):** et team på vanvittigt overarbejde havde elendig kvalitet og brandslukning. Da timerne kom ned, blev **produktivitet og kvalitet mærkbart bedre**. *"Burning people out is Evil."*

### Pair Programming
**Al produktionskode skrives af to ved én maskine.** Par holder hinanden på opgaven, brainstormer, afklarer, tager over ved blokering og holder hinanden ansvarlige.
- Man må gerne tænke og prototype alene, men **tag idéen med tilbage, ikke koden**
- Trættende: max 5-6 timer om dagen. **Rotér par** hyppigt
- **Personal space:** forskellige behov for afstand; hygiejne; opstår tiltrækning, stop med at parre. Er du utilpas, så tal med nogen

> **Fra praksis:** forbedrer **kodekvalitet** og **fokus**, spreder viden **overraskende hurtigt**. Mange imod har aldrig prøvet det. Udmattende; skift ofte. **Code review er et OK alternativ.** Navigatøren bør have sin egen computer til opslag. **Tving det ikke ned over folk.**

Parprogrammering påvirker velocity, ikke estimater ([[Estimering og velocity#Velocity]]).

### Stories
**Planlæg med enheder af kundesynlig funktionalitet, og estimér dem, så snart de er skrevet.** Beck angriber ordet "requirement", og tidlig estimering lader forretning og teknik mødes. Alt om at skrive, opdele og teste dem: [[User stories]].

### Weekly Cycle
**Planlæg en uge ad gangen**: gennemgå fremdrift, lad kunden vælge stories, bryd i tasks. Start ugen med at **skrive de automatiserede tests**; mål: deploybar software fredag. **Planlægning er nødvendigt spild.** Svarer til sprint og sprint planning ([[Sprint planning]]).

### Quarterly Cycle
**Planlæg et kvartal ad gangen**: flaskehalse, reparationer, **temaer** og stories, det store billede. Temaer holder teamet fra at drukne i detaljer ([[Release planning]]).

### Slack
**Læg små opgaver ind, der kan droppes.** At holde aftaler, også beskedne, genopbygger tillid. Firehjulstræk-analogien: kør på to hjul, så har du reserve. Mellemlederen: *"går jeg ikke med til urealistiske planer, bliver jeg fyret"*; direktøren dagen efter: *"de kommer aldrig i mål, det er okay"*. Overcommitment giver fejl, dårlig moral og fjendtlige relationer. Slack kan være én "Geek Week" ud af otte eller 20 % af tiden ([[Under sprinten#Slack]]).

### Ten-Minute Build
**Byg hele systemet og kør alle tests automatisk på ti minutter.** Længere bruges sjældnere; det er softwarens nærmeste "naturkonstant". Tre spor: *automatisk*, *hele* systemet, *alle* tests. Automatiske builds **sænker stress**: *"lad os bare bygge og se."*

### Continuous Integration
**Integrér og test ændringer efter højst et par timer.** Teamprogrammering er *divide, conquer and integrate*; jo længere man venter, jo dyrere og mere uforudsigeligt.

| Asynkron CI | Synkron CI (Becks foretrukne) |
|---|---|
| Check ind → buildserver tester → besked ved fejl | Parret venter på build og tests efter hver session; ventetiden er **refleksionstid** |

Integrér et **komplet produkt**, så første deployment ikke er en big deal.

> **Fra praksis:** Maven og QuickBuild. Den ultimative løsning på **"det virker på min maskine"**; build-serveren er **dommeren**. *"Worth every minute."* Næste skridt er **continuous delivery**.

### Test-First Programming
**Skriv en fejlende automatiseret test, før du ændrer kode.**

| Problem | Hvordan test-first hjælper |
|---|---|
| **Scope creep** | Fokus: vil du have mere kode, så skriv en test til |
| **Coupling og cohesion** | Svær at teste = **designproblem** |
| **Trust** | Kode der virker + tests der viser intentionen |
| **Rhythm** | Klart næste skridt: **test, code, refactor** |

Test-first-tests er et **mikroview**, men hurtige nok til tusindvis i ten-minute buildet. Acceptancetests er det tilsvarende på kundeniveau ([[Test og kvalitet#Acceptance tests]]).

> **Fra praksis, den vigtigste nuancering:** Kniberg var religiøs om TDD, men nu er **TDD en nicheteknik, som få har tålmodighed til at mestre**. TDD er svært, men har en dybt positiv effekt på design. **De fire principper han coacher i stedet:**
> 1. Hver nøglefeature har **mindst én end-to-end acceptancetest**
> 2. **Kompleks eller forretningskritisk kode** har unit tests
> 3. Noget kode er udækket, og **det er fint**, hvis det er en **bevidst afvejning**
> 4. **Skriv testene undervejs**
>
> Resultat: ca. **70 % coverage**. **Testautomatisering er afgørende; fuld TDD er valgfrit.** TDD på ny kode altid; på legacy-kode er det virkelig svært.
>
> **Lærestregen:** et team brugte måneder på at automatisere en manuel regressionstest uden held. Så spurgte de *"hvordan gør vi den manuelle test mindre tidskrævende?"* og byggede genveje og scripts. **Byg først det, der gør den manuelle test lettere.**

### Incremental Design
**Investér i designet hver dag**, så det passer til dagens behov. Beck angriber antagelsen om, at ændringer bliver eksponentielt dyrere over tid (Boehms data om **defekter**): gælder det også for ændringer, og under hvilke betingelser ikke? XP skaber betingelserne med tests, løbende designforbedring og social proces.

⚠️ Misforståelsen fra 1. udgave: teams overså ordet *responsible* i "det sidste **ansvarlige** øjeblik" og stablede stories uden design. Rådet er at holde designinvesteringen **i proportion til behovet**. Heuristik: **fjern duplikering**. **Refactoring** kodificerer mønstrene.

> **Fra praksis:** rimeligt godt; af og til graver et dårligt design sig for godt ned. **Løbende designforbedring er mest en sidegevinst ved TDD.**

---

## To corollary practices, Kniberg fremhæver

**Collective code ownership:** parprogrammering med hyppig rotation giver det automatisk. Teams med højt kollektivt ejerskab er **robuste**: sprinten dør ikke, fordi én bliver syg. Spotify: **internal open source** med pull requests.

**Coding standard:** *"Very useful, wish we had done it earlier."* Start simpelt; skriv kun det ikke-oplagte ned. *"Du må bryde reglerne, men dokumentér en god grund."* Eksempler: fang **aldrig** exceptions uden at logge stacktrace; collections returnerer aldrig null.

> **Becks afslutning:** praksisserne giver et fundament af respekt, kommunikation og feedback. **Den store gevinst kommer først, når de sidder fast**, og næste skridt er forretningsrelationer, der understøtter udviklingen.
