---
tags: [distribuerede-systemer, moc, teori, eksamen]
kilder: ["Coulouris kap. 1–2, 13, 16–17"]
---

# Distribuerede systemer

Indgangen til emnet: hvad et distribueret system er, og hvordan noterne hænger sammen.

## Noterne

| Note | Indhold |
|---|---|
| [[Trends og fysiske modeller]] | Pervasive networking, mobile/ubiquitous, multimedie, cloud; de tre generationer |
| [[Udfordringer i distribuerede systemer]] | De 8 challenges (eksamensstof) |
| [[Arkitekturmodeller]] | Entiteter, kommunikationsparadigmer, klient/server vs. P2P, tiers, middleware |
| [[Fundamentale modeller]] | Interaktions-, fejl- og sikkerhedsmodel |
| [[Navne og navneopløsning]] | Navne, adresser, name spaces, opløsning, caching |
| [[DNS]] | Domæner, zones, resource records, BIND |
| [[Directory services, X.500 og GNS]] | Yellow pages, X.500/LDAP, Global Name Service |
| [[Transaktioner og ACID]] | ACID, serial equivalence, recoverability, nested transactions |
| [[Concurrency control]] | Locks, deadlocks, optimistic og timestamp ordering (lokalt og distribueret) |
| [[Distribuerede transaktioner og 2PC]] | Coordinator/participants, two-phase commit, recovery |

Netværket under systemerne står i [[Netværk]], og sikkerhed i [[Sikkerhed]].

## Definition

*(Coulouris 1.1)*

> Et **distribueret system** er et system, hvor hardware- eller softwarekomponenter på **netværksforbundne computere** kommunikerer og koordinerer deres handlinger **udelukkende ved at sende beskeder**.

Der er ingen delt hukommelse, og computerne kan være vilkårligt langt fra hinanden.

### De tre konsekvenser (klassisk eksamensstof)

| Konsekvens | Betydning |
|---|---|
| **Concurrency** | Samtidig udførelse er **normen**. Kapacitet øges ved at tilføje computere, men koordineringen af delte ressourcer skal håndteres eksplicit |
| **No global clock** | Der er grænser for, hvor præcist ure kan synkroniseres over et netværk; der findes ingen enkelt korrekt global tid. Delvist løst med **logisk tid** ([[Fundamentale modeller]]) |
| **Independent failures** | Hver komponent kan fejle, mens resten kører videre. Netværksfejl isolerer computere, men stopper dem ikke; et program kan ikke skelne "netværket er nede" fra "netværket er langsomt"; et crash bliver ikke automatisk kendt |

> Huskeregel: **Concurrency · No global clock · Independent failures**

## Motivationen: ressourcedeling

*(Coulouris 1.4)*

Hovedmotivationen er **at dele ressourcer**: hardware (diske, printere), data (filer, databaser) og streams (video, lyd). Hardware deles for at spare penge, men for brugerne er det **højere-niveau-ressourcer**, der tæller: en database, en søgemaskine. Delingsmønstrene varierer fra en søgemaskine (brugere, der aldrig har kontakt) til **CSCW** (en lille gruppe, der arbejder direkte sammen).

> En **service** er en afgrænset del af systemet, der **administrerer en samling relaterede ressourcer** og præsenterer deres funktionalitet. Den eneste adgang er via de operationer, den eksporterer.

Det er både god indkapsling og en fysisk nødvendighed: ressourcer er indkapslet i computere og kan kun tilgås via kommunikation. Klient/server-modellen, der bygger på dette, står i [[Arkitekturmodeller#Client-server]].

Deling er også grunden til, at vi har brug for sikkerhed: ressourcer, der ikke deles, kan bare isoleres ([[Sikkerhed]]).

## Eksempler

*(Coulouris 1.2)*

**Web search (Google):** et af de største DS nogensinde. Et distribueret filsystem til meget store filer, et struktureret distribueret lager, en **lock service** og en programmeringsmodel til store parallelle beregninger.

**MMOGs** (fx EVE Online, >50.000 samtidige spillere) kræver hurtig respons og et **konsistent view** af den delte verden:

| Tilgang | Eksempel | Karakteristik |
|---|---|---|
| Centraliseret klient-server (cluster) | EVE Online | Én kopi af verdenstilstanden; nemmere konsistens |
| Distribuerede servere | EverQuest | Universet partitioneres; naturligt skalerbart |
| Peer-to-peer | Forskning | Fuldt decentraliseret |

**Financial trading:** fokus på **events**, der skal leveres pålideligt og rettidigt til mange klienter, via **publish-subscribe**. Heterogene kilder oversættes af **adaptere**. **Complex Event Processing** sammensætter events til mønstre ("hvis kursen afviger 2 % … inden for 2 minutter, så køb").

## Den røde tråd

**Systemmodellerne** giver sproget til at beskrive og ræsonnere om systemerne *(Coulouris 2)*:

| Modeltype | Spørgsmål den besvarer |
|---|---|
| **Fysisk model** → [[Trends og fysiske modeller]] | Hvilken hardware og hvilke netværk? |
| **Arkitekturmodel** → [[Arkitekturmodeller]] | Hvilke komponenter, roller og kommunikation? |
| **Fundamental model** → [[Fundamentale modeller]] | Hvad kan vi antage om tid, fejl og sikkerhed? |

> Modellerne er direkte svar på challenges: middleware løser *heterogeneity*, caching og replikering løser *scalability*, og fejlmodellen formaliserer *failure handling*.

**Adresser vs. navne:**

| Lag | Hvad identificeres | Problem ved flytning | Løsning |
|---|---|---|---|
| **Netværk** | **Adresser**: hvor en host sidder | Routing er subnetbaseret | **MobileIP** holder adressen stabil ([[Network layer og IP routing]]) |
| **Navngivning** | **Navne**: hvad en ressource er | Adressen bag et navn ændrer sig | **DNS** holder navnet stabilt ([[Navne og navneopløsning]]) |

**Transaktioner i to skalaer:**

| | **Én server** | **Flere servere** |
|---|---|---|
| **Atomicity** | Coordinator committer eller aborterer | **Two-phase commit** |
| **Isolation** | Serial equivalence via locking / optimistic / timestamp | Samme metoder **plus** global serialisering |
| **Deadlock** | Cyklus i den lokale wait-for graf | Cyklus i den **globale** graf, fundet med **edge chasing** |
| **Durability** | Tentative versions → permanent storage | **Recovery manager** med intentions lists |

> Concurrency control er **modulær** (hver server passer sine egne objekter), men atomicity og global serializability kræver **ekstra protokoller på tværs**. Og selvom konsensus ikke kan opnås i et asynkront system med fejl, **opnår 2PC den alligevel**, fordi crashede servere erstattes af processer, der genskaber deres tilstand fra permanent storage.
