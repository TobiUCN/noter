---
tags: [distribuerede-systemer, challenges, transparens, skalerbarhed, middleware, eksamen]
kilder: ["Coulouris 1.5"]
---

# Udfordringer i distribuerede systemer

Del af [[Distribuerede systemer]]. De **8 challenges** er kernestoffet i Coulouris kap. 1 *(Coulouris 1.5)*.

> Huskeliste: **Heterogeneity · Openness · Security · Scalability · Failure handling · Concurrency · Transparency · Quality of service**

---

## 1. Heterogeneity
Variation på fem områder:
1. **Netværk:** maskeres af internetprotokollerne
2. **Hardware:** fx forskellig **byte ordering**
3. **Operativsystemer:** alle implementerer IP, men med forskellige API'er
4. **Programmeringssprog:** forskellig repræsentation af tegn og datastrukturer
5. **Implementationer fra forskellige udviklere:** kræver fælles standarder

> **Middleware** er et softwarelag, der giver en **programmeringsabstraktion** og **maskerer heterogeniteten** i netværk, hardware, OS og sprog. Eksempler: CORBA (sprogneutral), Java RMI (ét sprog). Detaljer i [[Arkitekturmodeller#Middleware]].

**Mobile code** (kode, der flyttes og køres et andet sted) er bundet til instruktionssæt og OS. **Virtuelle maskiner** løser det: compileren genererer kode til en VM (fx JVM), som kun skal implementeres én gang pr. platform. Den mest udbredte mobile code i dag er **JavaScript**.

## 2. Openness
> **Åbenhed** afgør, om et system kan **udvides og reimplementeres** på forskellige måder, primært om nye ressourcedelingsservices kan tilføjes og bruges af mange klienter.

- Kræver, at **nøgleinterfaces publiceres** (fx IETF's **RFC'er**, **W3C**)
- Åbne DS bygger på en **ensartet kommunikationsmekanisme** + publicerede interfaces
- De kan bygges af heterogen hardware og software fra forskellige leverandører, men overholdelse af standarden skal testes
- Sidegevinst: **uafhængighed af enkeltleverandører**

Webbet er et eksempel på et åbent system ([[Application layer#World Wide Web|WWW]]).

## 3. Security
Tre komponenter: **confidentiality** (mod afsløring), **integrity** (mod ændring) og **availability** (mod forstyrrelse af adgang).

- **Løst med kryptering:** at sende følsom information sikkert og at **identificere en fjern bruger** korrekt
- **Ikke fuldt løst:** **denial of service** og **sikkerhed for mobile code**

Hele emnet står i [[Sikkerhed]].

## 4. Scalability
> Et system er **skalerbart**, hvis det forbliver effektivt ved en **betydelig stigning i antallet af ressourcer og brugere**.

| Udfordring | Krav / eksempel |
|---|---|
| **Kontrollér omkostningen til fysiske ressourcer** | Højst **O(n)** for n brugere |
| **Kontrollér performancetab** | Hierarkiske strukturer giver **O(log n)**, fx DNS |
| **Undgå at softwareressourcer løber tør** | 32-bit IP-adresser → IPv6. Overkompensering koster også |
| **Undgå flaskehalse** | **Decentralisér**. DNS erstattede én central navnefil med partitionerede tabeller |

Teknikker: **replikering**, **caching** og **flere servere**. Default routes, CIDR og NAT er netværkets svar ([[Network layer og IP routing]]).

## 5. Failure handling
Fejl i DS er **partielle**: nogle komponenter fejler, andre fortsætter.

| Teknik | Beskrivelse |
|---|---|
| **Detecting** | Nogle fejl kan opdages (checksum); en crashet fjernserver kan typisk kun **mistænkes** |
| **Masking** | Skjul eller mildn fejl: gensend beskeder, skriv til **to** diske |
| **Tolerating** | Klienter tåler fejl, fx informerer browseren brugeren i stedet for at prøve i evighed |
| **Recovery** | Permanente data kan **rulles tilbage** til en konsistent tilstand ([[Distribuerede transaktioner og 2PC#Transaction recovery]]) |
| **Redundancy** | To ruter mellem routere, DNS-tabeller på mindst to servere, replikerede databaser |

**Availability** = andelen af tiden, systemet er tilgængeligt. Fejlklasserne formaliseres i [[Fundamentale modeller#Fejlmodellen]].

## 6. Concurrency
Flere klienter tilgår samme ressource samtidig (fx bud på en auktion). Én request ad gangen begrænser throughput, så requests behandles i tråde. Uden kontrol kan `Smith: $122` og `Jones: $111` ende byttet om.

> Ethvert objekt, der repræsenterer en delt ressource, er **selv ansvarligt** for at fungere korrekt i et samtidigt miljø, fx med **semaforer**. Se [[Transaktioner og ACID]] og [[Concurrency control]].

## 7. Transparency
> **Transparens** = at **skjule** adskillelsen af komponenter, så systemet opfattes som **en helhed**.

| Form | Betydning |
|---|---|
| **Access** | Lokale og fjerne ressourcer tilgås med **identiske operationer** |
| **Location** | Adgang **uden kendskab til placering** |
| **Concurrency** | Samtidig brug **uden indbyrdes forstyrrelse** |
| **Replication** | Replikaer bruges **uden at brugeren kender dem** |
| **Failure** | Fejl skjules, så opgaver kan fuldføres |
| **Mobility** | Ressourcer og klienter kan **flytte sig** |
| **Performance** | Rekonfiguration ved varierende belastning |
| **Scaling** | Vækst uden ændring af struktur eller algoritmer |

**Access + location = network transparency.**

Eksempler:
- **Access:** samme mappevisning for lokale og fjerne filer. *Manglende:* at skulle bruge `ftp`
- **Location:** URL'er, fordi domænenavnet ikke er en IP-adresse
- **Ikke mobility-transparent:** en webside kan ikke flytte domæne, uden at links brydes
- **Forhindrer replication transparency:** DNS vælger kun **én** maskine pr. opslag
- **Network:** en e-mailadresse er uafhængig af modtagerens placering
- **Failure:** e-mail leveres til sidst, selv om servere fejler; middleware omsætter fejl til **exceptions**
- **Mobility:** mobiltelefoner, der skifter celle

> Transparens er **ikke altid ønsket**: den rejsende skal bruge den *lokale* mailserver, og et dokument skal printes på en navngiven printer tæt på brugeren.

## 8. Quality of Service
De vigtigste **ikke-funktionelle** egenskaber: **reliability, security, performance** og **adaptability**. Performance er redefineret som evnen til at **overholde tidsgarantier**, især for multimedie.

QoS kræver **garanterede** ressourcer, **reservation** af kritiske ressourcer og ressourceadministratorer, der **afviser** requests, de ikke kan opfylde. Det gælder både netværk og OS. Nutidens netværk giver **ingen garantier** under høj belastning.
