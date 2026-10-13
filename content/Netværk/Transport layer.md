---
tags: [netværk, transport-layer, tcp, udp, handshake, flow-control, congestion-control, eksamen]
kilder: ["Deitel 16.6"]
---

# Transport layer

Del af [[Netværk]], lag 2 nedefra i [[TCP-IP protocol stack]]. **Det mest eksamensrelevante afsnit i Deitel kap. 16.**

> Transportlaget har ansvaret for **end-to-end**-kommunikation: det modtager data fra applikationslaget, **bryder det i mindre stykker**, sætter kontrolinformation på og sender videre til netværkslaget *(Deitel 16.6)*.

## De to grundtilgange

| Tilgang | Analogi | Konsekvens |
|---|---|---|
| **Connection-oriented** | **Telefonsystemet**: en forbindelse etableres og holdes hele sessionen | En tilstand, begge parter deler |
| **Connectionless** | **Postvæsenet**: to breve kan tage forskellige veje, ankomme på forskellige tidspunkter eller slet ikke | Ingen delt tilstand |

**Problemet:** netværk er **unreliable**. Data kan ankomme korrupt, ude af rækkefølge, som dubletter eller slet ikke; netværket gør kun **"best effort"**.

> Connection-oriented services **påtvinger pålidelighed oven på et upålideligt netværk**. Pålideligheden bygges i endepunkterne. Det er **the end-to-end argument** i praksis ([[Arkitekturmodeller]]).

**Handshaking:** hosts udveksler kontrolinformation for at etablere forbindelsen og for at regulere afslutningen. Connectionless undgår hele det overhead.

---

## TCP

*(Deitel 16.6.1)*

Connection-oriented. Garanterer, at data (**segments**) ankommer **ubeskadiget og i korrekt rækkefølge**, med error control, congestion control og retransmission. HTTP og FTP kan derfor sende data *"lige så enkelt og pålideligt som at skrive til en fil på en lokal computer"*.

### Three-way handshake
Formålet er **at synkronisere sequence numbers**, ikke bare at sige hej.

| Trin | Segment | Indhold |
|---|---|---|
| 1 | **SYN** (klient → server) | Anmodning + **klientens sequence number** |
| 2 | **SYN/ACK** (server → klient) | Bekræftelse + **serverens sequence number** |
| 3 | **ACK** (klient → server) | Færdiggør forbindelsen |

Sequence number øges med én pr. sendt segment og bruges til at **omarrangere** segmenter, der kommer ude af rækkefølge.

### Retransmission
- Modtageren sender en **ACK** med segmentets sequence number
- Får afsenderen ingen ACK, **gensendes** segmentet efter en ventetid
- Alle segmenter kommer frem, dubletter kasseres, rækkefølgen genskabes

> Garantien kræver en **buffer** til segmenter, der kom for tidligt, og den koster **latency**: korrekt modtagne data må vente på et manglende segment foran dem. Den ventetid kan streaming ikke tåle.

### Flow control vs. congestion control (klassisk eksamensspørgsmål)

| | Beskytter | Mod |
|---|---|---|
| **Flow control** | **Modtageren** | At få flere segmenter, end den kan behandle |
| **Congestion control** | **Netværket** | Generel overbelastning |

Begge bruger **samme mekanisme**: et **TCP window**. Afsenderen må ikke sende flere segmenter, end vinduet angiver, før den får en ACK, og modtageren sender sit vindue med hver ACK.

| Vindue | Effekt |
|---|---|
| **Stort** | Kan netværket eller modtageren ikke følge med, kasseres segmenter → retransmission → ineffektivitet |
| **Lille** | Netværket bliver **underudnyttet** |

Routere **dropper datagrammer uden varsel**, når deres køer er fulde ([[Network layer og IP routing#Routerkøer]]). TCP tolker et tabt segment som tegn på congestion og sænker farten. Det svarer til at bremse producenten i producer-consumer, bare uden en central instans.

---

## UDP

*(Deitel 16.6.2)*

Connectionless. **Minimalt overhead**. Enhederne kaldes **datagrams**, og der er ingen garanti for levering eller rækkefølge. Besparelsen: **små headers** og **mindre trafik** (ingen ACKs, handshake eller retransmission). Et tabt datagram opdager afsenderen slet ikke.

### Tre grunde til at vælge upålidelig kommunikation
1. **Pålidelighed er ikke nødvendig**
2. **Applikationen tåler tab:** streaming klarer et tabt datagram med et lille "hikke". Over TCP ville det give en **betydelig pause**, mens det tabte segment gensendes
3. **Applikationen vil have sin egen pålidelighedsmekanisme**, bygget oven på UDP

> Pointe 2 er den vigtige: TCP's pålidelighed er **aktivt skadelig** for tidskritiske data. Lyd, der skulle have været afspillet for 200 ms siden, er værre at vente på end at springe over.

Samme egenskab gjorde UDP til et perfekt spredningsvåben for **Slammer-wormen**: ingen handshake pr. offer ([[Trusler og angreb]]).

## TCP vs. UDP

| | TCP | UDP |
|---|---|---|
| Model | Connection-oriented | Connectionless |
| Enhed | **Segment** | **Datagram** |
| Handshake | **3-way** | Ingen |
| Levering og rækkefølge garanteret | Ja | Nej |
| ACKs / retransmission | Ja | Nej |
| Flow & congestion control | Ja (window) | Nej |
| Header | Stor | Lille |
| Bruges af | HTTP, FTP | Streaming, RIP |

**Tommelfingerregel:** TCP, når **korrekthed** betyder mest (filer, HTML, bank); UDP, når **rettidighed** betyder mest, eller når applikationen selv vil styre pålideligheden.

TCP garanterer levering, men **ikke** at data er uændrede af en angriber; det kræver TLS ([[Sikre protokoller - TLS, IPsec og WiFi]]).
