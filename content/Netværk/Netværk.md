---
tags: [netværk, moc, topologi, lan, wan, eksamen]
kilder: ["Deitel kap. 16", "Coulouris 3.4"]
---

# Netværk

Indgangen til netværksemnet. Underviserens prioritering for Deitel kap. 16: **fokus på 16.4–16.8** (stakken og de fire lag); topologier (16.1–16.3) og klient/server (16.9) skimmes.

## Noterne

| Note | Indhold |
|---|---|
| [[TCP-IP protocol stack]] | Lagdeling, de fire lag, encapsulation, OSI vs. TCP/IP |
| [[Application layer]] | URI/URL/socket, porte, HTTP + MIME, FTP, WWW |
| [[Transport layer]] | TCP vs. UDP, three-way handshake, flow vs. congestion control |
| [[Network layer og IP routing]] | Routing, RIP/OSPF, IPv4/IPv6, CIDR, NAT, tunneling, MobileIP |
| [[Link layer]] | Checksum vs. Hamming, CSMA/CD, Token Ring, FDDI, 802.11 |

Tilstødende emner: klient/server og tiers står i [[Arkitekturmodeller]], navne og DNS i [[DNS]], og sikkerhed på hvert lag i [[Sikre protokoller - TLS, IPsec og WiFi]].

## Den røde tråd

Stakken kan læses som ét spørgsmål: *hvordan kommer en besked pålideligt fra én proces til en anden over et upålideligt medie?* Hvert lag svarer på sin del *(Deitel 16)*:

| Lag | Spørgsmålet det besvarer | Hvad det tager for givet |
|---|---|---|
| **Application** | Hvad **betyder** beskeden? | At bytes kommer frem korrekt |
| **Transport** | Kommer det **hele** frem, i **rigtig rækkefølge**, uden at overvælde nogen? | At datagrammer kan flyttes mod destinationen |
| **Network** | Hvilken vej skal **næste hop** gå? | At en frame kan sendes til nabonoden |
| **Link** | Hvordan bliver bits til **signal**, og hvordan opdages fejl? | Ingenting; her møder abstraktionen fysikken |

> **Den vigtigste enkeltskelnen:** transportlaget arbejder **end-to-end** (afsenderproces → modtagerproces), netværkslaget arbejder **hop-for-hop** (host → næste host). Næsten hvert spørgsmål om "hvem har ansvaret for X" kan besvares ud fra den skelnen.

### Gennemgående temaer

| Tema | Hvor det optræder |
|---|---|
| **Pålidelighed koster tid** | TCP vs. UDP · checksum vs. Hamming · two-tier vs. n-tier |
| **Redundans som fejltolerance** | Mesh-topologi · FDDI's anden ring · TCP's retransmission |
| **Randomisering bryder symmetri** | Ethernets exponential backoff · RIP's tilfældige opdateringsperiode |
| **Reservation vs. konflikt** | Token Ring/FDDI og RTS/CTS (bed om lov) vs. Ethernet (bed om tilgivelse) |
| **Delt ressource under pres → køer, der løber over** | Routerkøer · TCP window · stjernens hub |
| **Modularisering betales med latency og overhead** | Lagdelingen i stakken · n-tier |
| **Pak det nye ind i det gamle** | Tunneling: IPv6-over-IPv4 · MobileIP · IPsec/VPN |

### Forbindelsen til distribuerede systemer
Netværket er **infrastrukturen under** [[Distribuerede systemer]].

| Netværk | Distribuerede systemer |
|---|---|
| Pålidelighed bygget i endepunkterne (TCP) | **The end-to-end argument** ([[Arkitekturmodeller]]) |
| HTTP som request/response | **Request-reply, RPC og RMI** ([[Arkitekturmodeller]]) |
| Routerens ufuldstændige billede af netværket | **Interaktions- og fejlmodel** ([[Fundamentale modeller]]) |
| IP-**adresser** siger, *hvor* en host er | **Navne** siger, *hvad* en ressource er ([[Navne og navneopløsning]]) |

---

## Grundbegreber

*(Deitel 16.1)*

| Begreb | Definition |
|---|---|
| **Host** | En entitet, der modtager og leverer services over et netværk |
| **Link** | Det **medie**, services transmitteres over |
| **Protokol** | Et sæt regler for, hvordan to entiteter skal interagere |

Går et link i stykker, fejler en host, eller mistes en besked, afbrydes kommunikationen. Lagdelingen findes for at håndtere de fejl **ét sted ad gangen**.

## Topologier

*(Deitel 16.2)*

**Topologi** beskriver relationen mellem hosts (**nodes**). En logisk topologi viser, hvilke noder der er **direkte forbundne**. **Attenuation** (signalet taber styrke over afstand) begrænser den fysiske udstrækning.

| Topologi | Struktur | Styrke | Svaghed |
|---|---|---|---|
| **Bus** | Alle noder på **ét fælles link** | Simpel. Én node fejler → resten kører videre | Ingen retransmission → begrænset længde. **Busen fejler → alt fejler** |
| **Ring** | Hver node har **præcis to** forbindelser | Kan blive større end bus, fordi noder videresender | Retransmission delay pr. node. **Én node fejler → hele ringen fejler** |
| **Star** | Central **hub**, al trafik gennem den | Lav delay (én mellemnode). Overlever fejl i yderknuder | **Hubben fejler → alt fejler**, og den er en **flaskehals** |
| **Tree** | Hierarki af stjerner | Noder, der kommunikerer meget, samles i samme undertræ | Hub-afhængighed på hvert niveau |
| **Mesh** | Mindst to noder har flere veje imellem sig | **Mest fault-tolerant** | **Routingkompleksitet** |
| **Fully-connected mesh** | Hver node forbundet til alle | Routing er triviel | Antallet af links eksploderer |

> Bus, ring og star har hver et **single point of failure**. Mesh fjerner det med **redundans** og betaler med **routingkompleksitet**, som netværkslaget findes for at håndtere. Missionskritiske systemer bygges derfor ikke som ring.

**Ad hoc-netværk:** spontane netværk, hvor enheder kobler sig på og forlader tilfældigt. Topologien ændrer sig hurtigt, så en central node kan ikke styre netværket. Det er baggrunden for CSMA/CA og RTS/CTS i [[Link layer]].

## LAN vs. WAN

*(Deitel 16.3)*

| | **LAN** | **WAN** |
|---|---|---|
| Udstrækning | Begrænset (bygning, campus) | Mange LANs over store afstande |
| Topologi | Valgfri | Generelt **mesh** |
| Hastighed | Høj | Lavere |
| Fejlrate | Lav | Højere (heterogene netværk) |
| Kontrol | **Autonomt**, ejeren bestemmer | Delt |

**Internettet er det største WAN.** At dele op i subnetværk giver hurtigere transmission, højere kapacitet og ledelsesmæssig fleksibilitet. Det er modularisering igen, og det er det, **IP** understøtter ved at koble mindre netværk sammen ([[Network layer og IP routing]]).
