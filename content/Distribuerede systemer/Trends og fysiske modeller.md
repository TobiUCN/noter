---
tags: [distribuerede-systemer, trends, cloud, mobile, ubiquitous, fysisk-model]
kilder: ["Coulouris 1.3, 2.1–2.2"]
---

# Trends og fysiske modeller

Del af [[Distribuerede systemer]]. Trends driver udviklingen *(Coulouris 1.3)*, og den fysiske model beskriver, hvordan hardwaren under systemerne har ændret sig som følge af dem *(Coulouris 2.2)*.

## De fire trends

### 1. Pervasive networking
Internettet sammenkobler mange netværkstyper (WiFi, Bluetooth, 3G …), og netværk er blevet en **allestedsnærværende ressource**.

| Begreb | Betydning |
|---|---|
| **Intranet** | Delnetværk drevet af en organisation, typisk bag en **firewall** ([[Forsvarsmekanismer]]) |
| **ISP** | Leverer forbindelse og lokale services til brugere og små organisationer |
| **Backbone** | Forbindelse med meget høj kapacitet, der binder intranets sammen ([[Network layer og IP routing]]) |

Internettet er selv et meget stort, **open-ended** distribueret system. Firewalls kan også være et problem, fordi de spærrer for legitim deling.

### 2. Mobile og ubiquitous computing
- **Mobile computing:** computeropgaver på farten, med adgang til internettet, hjemme-intranettet og **lokale ressourcer** (location-/context-aware computing)
- **Ubiquitous computing:** mange små, billige enheder i omgivelserne, så indlejret i hverdagsting, at de knap bemærkes

De overlapper, men er forskellige. Nye krav: **variabel forbindelse**, **mobility transparency**, **spontaneous interoperation** og **service discovery**. MobileIP er ét svar ([[Network layer og IP routing#MobileIP|MobileIP]]).

### 3. Distribuerede multimedie-systemer
**Kontinuerte medier** (lyd, video) har en **tidsdimension**: integriteten afhænger af, at real-time-relationerne bevares (frames pr. sekund, maks. latency). Det er **quality of service**. **Webcasting** kræver understøttelse af mange formater, QoS-mekanismer, ressourcestyring og **adaptationsstrategier**, når QoS ikke kan holdes.

### 4. Distributed computing as a utility
Ressourcer **lejes** i stedet for at ejes, som vand og strøm: fysiske ressourcer (lager, beregning, typisk **virtualiseret**) og softwareservices (mail, kalender).

> En **cloud** er et sæt internetbaserede applikations-, lager- og beregningsservices, der dækker de fleste brugeres behov, så de helt eller delvist kan undvære lokalt lager og software. "Alt som en service", betalt pr. forbrug.

Clouds kører typisk på **clusters**: tæt samarbejdende computere, ofte commodity-PC'er med Linux eller **blade servers**. **Grid computing** er en forløber med bias mod videnskabelige applikationer.

---

## Fysiske modeller

> En **fysisk model** repræsenterer de underliggende hardwareelementer og **abstraherer væk fra konkrete teknologidetaljer**. Den minimale model er et **udvideligt sæt computer-noder forbundet af et netværk** *(Coulouris 2.2)*.

Fysiske modeller er den mest eksplicitte af de tre modeltyper; de andre er [[Arkitekturmodeller]] og [[Fundamentale modeller]].

### Vanskeligheder designere står over for

*(Coulouris 2.1)*

| Kategori | Eksempler |
|---|---|
| **Varierende brugsmønstre** | Millioner af hits, afbrudte mobile enheder, multimedie med krav om lav latency |
| **Bredt spektrum af miljøer** | Heterogen hardware, OS og netværk; skala fra titusinder til millioner |
| **Interne problemer** | Ikke-synkroniserede ure, konfliktende opdateringer, mange fejltyper |
| **Eksterne trusler** | Angreb på integritet og fortrolighed, DoS |

### De tre generationer

| | **Early** (1970'erne–80'erne) | **Internet-scale** (1990'erne) | **Contemporary** |
|---|---|---|---|
| Infrastruktur | 10–100 noder på et LAN (Ethernet) | Netværk af netværk | Op til hundredtusindvis af noder |
| **Skala** | Small | Large | Ultra-large |
| **Heterogenitet** | Begrænset | Betydelig: netværk, OS, sprog | Nye dimensioner: fra sensorer til grids |
| **Åbenhed** | Ikke en prioritet | Stor prioritet → åbne standarder, middleware (CORBA, web services) | Forskningsudfordring |
| **QoS** | I sin vorden | Stor prioritet | Forskningsudfordring |

**Contemporary:** noderne var før **statiske, diskrete og autonome** desktopcomputere. Trendsene ovenfor har ændret det:

| Trend | Konsekvens for den fysiske model |
|---|---|
| **Mobile computing** | Noder **flytter sig** → service discovery |
| **Ubiquitous computing** | Computere **indlejret** i hverdagsting |
| **Cloud/cluster** | **Puljer af noder**, der sammen leverer én service |

### Systems of systems
Ultra-large-scale-systemer beskrives som **"systems of systems"** (parallel til "network of networks"): delsystemer, der selv er systemer, og som sammen løser en opgave. *Eksempel:* oversvømmelsesvarsling med sensornetværk, simuleringer på clusters, historiske data og varsler til mobiltelefoner.
