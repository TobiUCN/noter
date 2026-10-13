---
tags: [distribuerede-systemer, arkitektur, klient-server, peer-to-peer, n-tier, middleware, rpc, eksamen]
kilder: ["Coulouris 1.4, 2.3", "Deitel 16.9"]
---

# Arkitekturmodeller

Del af [[Distribuerede systemer]].

> **Arkitekturen** af et system er dets **struktur** i form af separat specificerede komponenter og deres relationer. Målet er en struktur, der er **pålidelig, håndterbar, tilpasningsdygtig og omkostningseffektiv** *(Coulouris 2.3)*. At forstå **trade-offs** mellem valgene er den vigtigste færdighed i DS-design.

Noten går fra **arkitekturelementer** → **arkitekturmønstre** → **middleware**.

## Arkitekturelementer

Fire nøglespørgsmål:
1. **Hvad** er de entiteter, der kommunikerer?
2. **Hvordan** kommunikerer de?
3. Hvilke **roller og ansvar** har de?
4. Hvordan er de **placeret** på den fysiske infrastruktur?

### Kommunikerende entiteter
**System-orienteret:** normalt **processer** (eller strengt taget **tråde**; i sensornetværk **noder**).

**Problem-orienteret:**

| Abstraktion | Karakteristik |
|---|---|
| **Objekter** | Samvirkende objekter, tilgået via **interfaces** specificeret i et **IDL** |
| **Komponenter** | Som objekter, men specificerer også de **antagelser**, komponenten gør om andre. Alle **afhængigheder er eksplicitte** → en fuldstændig kontrakt |
| **Web services** | Indkapsling + interfaces, men **integreret i webbet** og beskrevet med XML. Typisk komplette services på tværs af organisationer (B2B), hvor objekter og komponenter bruges internt |

### Kommunikationsparadigmer

**A. Interprocess communication:** lavniveau: message passing, **socket-programmering**, multicast.

**B. Remote invocation** (det mest udbredte):

| Teknik | Beskrivelse |
|---|---|
| **Request-reply** | Parvis udveksling: operation + argumenter → resultat. Primitivt; bruges i indlejrede systemer og i **HTTP** ([[Application layer]]) |
| **RPC** | Birrell & Nelson 1984, et stort gennembrud. Fjerne procedurer kaldes, **som om de var lokale**. Giver mindst **access- og location transparency** |
| **RMI** | RPC for **distribuerede objekter**, med objektidentitet og objektreferencer som parametre |

Fælles: kommunikationen er **tovejs**, afsenderen kender modtageren, og **begge skal eksistere samtidig**.

**C. Indirect communication** via en tredje entitet giver **space uncoupling** (afsenderen behøver ikke kende modtageren) og **time uncoupling** (de behøver ikke eksistere samtidig):

| Teknik | Beskrivelse |
|---|---|
| **Group communication** | One-to-many til en gruppe-id; modtagere **joiner** gruppen |
| **Publish-subscribe** | Publishers distribuerer **events** til subscribers via en mellemliggende service (fx financial trading) |
| **Message queues** | **Point-to-point** via en navngiven kø |
| **Tuple spaces** | Strukturerede data placeres i et **persistent** rum og hentes via mønstre (generative communication) |
| **Distributed shared memory** | Delte datastrukturer, som om de lå lokalt → høj transparens |

---

## Client-server

**Definitioner** *(Coulouris 1.4)*:

| Begreb | Definition |
|---|---|
| **Server** | En **proces**, der modtager requests fra andre computere, udfører en service og svarer |
| **Client** | Den anmodende proces |
| **Invocation** | Klientens request om en operation |
| **Remote invocation** | Hele interaktionen fra request til svar |

- **Klienter er aktive**, **servere er passive** (vågner ved requests). Servere kører kontinuerligt
- Ordene refererer til **processer** og til **rollen i én request**, ikke til maskinen. **Servere er ofte selv klienter**: en webserver er klient af en filserver og af **DNS**; en søgemaskine er server for browsere og klient via **web crawlers**

Client-server er den **historisk vigtigste og mest udbredte** arkitektur, men ikke alle DS passer på modellen.

### Peer-to-peer
Alle processer spiller **samme rolle**, kører samme program og tilbyder samme interfaces.

**Motivation:** client-server **skalerer dårligt**, fordi en service på én adresse er begrænset af én maskines kapacitet og båndbredde.

> **Nøgleindsigten:** de ressourcer, **brugerne selv ejer**, kan bruges til at understøtte servicen. **Ressourcerne vokser med antallet af brugere.**

Hver computer har kun en lille del af dataene; objekter **replikeres** for lastfordeling og modstandsdygtighed. Til gengæld er P2P **væsentligt mere komplekst** (objekter skal placeres, findes og holdes replikeret). Eksempler: Napster (ikke ren P2P), BitTorrent.

### Placering
Placering afgør performance, pålidelighed og sikkerhed, og der findes få universelle regler.

| Strategi | Beskrivelse |
|---|---|
| **Flere servere** | **Partitionér** objekterne (webbet: hver server sine ressourcer) eller **replikér** dem (Sun NIS). Tættere koblet: et **cluster** |
| **Caching** | Lager af nyligt brugte objekter **tættere på klienten**: i browseren eller i en delt **proxyserver**, der aflaster WAN og webservere |
| **Mobile code** | Fx applets: god interaktiv respons og **push-model**. Sikkerhedstrussel mod lokale ressourcer |
| **Mobile agents** | Kode **og** data rejser fra maskine til maskine og laver lokale kald. Begrænset anvendelighed pga. sikkerhed |

---

## Arkitekturmønstre

### Layering
Hvert lag bruger services fra laget under og tilbyder en abstraktion opad, som i [[TCP-IP protocol stack]]:

```
Applications, services
Middleware
--------------------------  }
Operating system            } Platform
Computer and network hardware  }
```

**Platform** = de laveste hardware- og softwarelag på hver computer (fx x86/Linux). **Middleware** maskerer heterogenitet og giver en bekvem programmeringsmodel.

### Tiered architecture
**Komplementær** til layering: layering er den **vertikale** organisering i abstraktioner; tiering organiserer funktionaliteten **inden for et lag** og placerer den på servere.

| Del | Ansvar |
|---|---|
| **Presentation logic** | Brugerinteraktion og view |
| **Application logic** | Den applikationsspecifikke behandling (business logic) |
| **Data logic** | Persistent lagring, typisk DBMS |

| | **Two-tier** | **Three-tier** |
|---|---|---|
| Fordeling | Klient og server; **applikationslogikken splittes** | Én tier pr. logisk element; logikken **ét sted** |
| Fordel | **Lav latency**: én beskedudveksling pr. operation | Vedligeholdelse; understøtter **thin clients** |
| Ulempe | Logik splittet på tværs af en procesgrænse | Tre servere at administrere; **mere trafik og latency** |

Deitel præsenterer klient/server som grundlæggende **two-tier**, hvor applikationslogikken ligger på klienten, serveren **eller begge**, og netop dét er problemet *(Deitel 16.9)*. **n-tier** (tre eller flere) giver fleksibilitet til mange klienter:

| Gevinst | Pris |
|---|---|
| **Modularisering**: hver tier kan ændres eller flyttes uafhængigt | **Øget latency**: hver request går gennem flere led |
| Fleksibel konfiguration | **Flere steder, netværket kan fejle** |

Samme afvejning som lagdelingen i netværksstakken: håndterbarhed købt med performance. Wikipedia bruger multi-tier til 60.000 requests i sekundet.

**Webapplikationen som three-tier** *(Deitel 16.9)*: **browser** (fortolker HTML) → **webserver** (HTTP, genererer sider dynamisk) → **relationel database**. Klient/server er ikke et ekstra lag i stakken, men et **arkitektonisk mønster oven på den**: HTTP → TCP → IP → Ethernet.

### AJAX
Standard-webinteraktion har tre begrænsninger: brugeren kan ikke interagere, mens en ny side hentes; selv små opdateringer kræver en **helt ny side**; og siden kan ikke opdateres, når serverdata ændres.

> **AJAX er "limen"**, der lader JavaScript i browseren sende requests til serveren og **opdatere siden selektivt** via `XmlHttpRequest`.

```javascript
new Ajax.Request('scores.php?game=Arsenal:Liverpool', {onSuccess: updateScore});

function updateScore(request) {
  // Resultatet parses, og den relevante del af siden opdateres.
}
```

`Ajax.Request` **returnerer straks**, så browseren fortsat reagerer; `updateScore` kaldes, når svaret kommer. Kommunikationen er næsten altid **asynkron**, mens serveren typisk laver en **synkron** query til databasen. *Eksempel:* Google Maps henter manglende kort-tiles med AJAX.

### Thin clients
Trenden er at flytte kompleksitet **væk fra brugerens enhed** og ud i services.

> En **thin client** understøtter en vinduesbaseret brugergrænseflade lokalt, mens applikationen kører på en **fjern computer**.

Ulempen er **stærkt interaktive grafiske opgaver** (CAD), hvor latency bliver uacceptabel. **VNC** opererer på et meget primitivt niveau (placér et rektangel af pixels), så det virker med ethvert OS og enhver applikation; det har afløst **network computers**.

### Andre mønstre

| Mønster | Understøtter | Beskrivelse |
|---|---|---|
| **Proxy** | **Location transparency** i RPC/RMI | Lokalt objekt med **samme interface** som det fjerne |
| **Brokerage** | **Interoperabilitet** | Service provider, requester og **broker**, fx RMI registry og CORBA naming service ([[Navne og navneopløsning]]) |
| **Reflection** | Introspection og intercession | Meta-level-interface til at opdage og ændre struktur og adfærd |

---

## Middleware

Middleware giver en **højere-niveau programmeringsabstraktion** og abstraherer over heterogenitet for at fremme **interoperabilitet og portabilitet**. Tidlige eksempler: RPC-pakker (Sun RPC) og gruppekommunikation (ISIS).

| Kategori | Eksempler |
|---|---|
| **Distributed objects** | RM-ODP, CORBA, Java RMI |
| **Distributed components** | Fractal, OpenCOM; application servers som EJB, JBoss |
| **Publish-subscribe** | CORBA Event Service, JMS |
| **Message queues** | JMS, Websphere MQ |
| **Web services** | Apache Axis; grid: Globus |
| **Peer-to-peer** | Pastry, Tapestry, Gnutella |

Kategorierne er ikke skarpe. **Application servers** understøtter three-tier direkte. Middleware leverer også infrastrukturelle services (sikkerhed, pålidelighed).

### The end-to-end argument
> **Saltzer, Reed & Clark (1984):** nogle kommunikationsfunktioner kan **kun implementeres fuldstændigt og pålideligt med viden fra applikationen i endepunkterne**. Det er derfor ikke altid fornuftigt at lægge dem i kommunikationssystemet (selvom en ufuldstændig version kan give performance).

*Eksempel:* en stor mail overføres over TCP, men TCP kan ikke komme sig over en lang afbrydelse. Mailtjenesten fører derfor selv protokol over fremdriften og genoptager over en ny forbindelse. TCP selv er også et eksempel: pålidelighed bygges i endepunkterne oven på et upålideligt netværk ([[Transport layer]]).

Argumentet går imod idéen om, at al kommunikation kan abstraheres væk med middleware. Den rigtige adfærd afhænger af applikationen og konteksten, hvilket driver **adaptiv middleware**.
