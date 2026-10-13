---
tags: [netværk, link-layer, ethernet, csma-cd, token-ring, fddi, 802-11, checksum, hamming, eksamen]
kilder: ["Deitel 16.8"]
---

# Link layer

Del af [[Netværk]], nederste lag i [[TCP-IP protocol stack]].

> Link-laget er grænsefladen til det **fysiske medie** (kobber, fiber, luft). Det omdanner et datagram, her kaldet en **frame**, til et elektrisk eller optisk signal og tilbage igen *(Deitel 16.8)*.

**Grundproblemet:** fysiske medier er udsat for **interferens**, som giver fejl. Link-laget forsøger at **detektere** og om muligt **korrigere** dem.

## Detektion vs. korrektion

| | **Checksum** | **Error-correcting code** (fx **Hamming Code**) |
|---|---|---|
| Kan | Kun **detektere** | **Detektere og korrigere** |
| Hvordan | Afsender beregner en værdi ud fra framens bits; modtager genberegner. Matcher de, er framen **sandsynligvis** ikke korrupt | **Redundante bits** bestemmer, hvilke bits der er korrumperet |
| Ved fejl | **Gensend** hele framen | Ingen gensendelse |
| Pris | Lav | **Ekstra bits pr. frame** og ekstra beregning |

> "Sandsynligvis": to frames kan give samme checksum, så det er en **sandsynlighedsgaranti**. En checksum er god mod tilfældige fejl, men ubrugelig mod en angriber, der kan ændre både data og checksum; det kræver en secure hash ([[Hashing, digitale signaturer og MAC'er]]).
>
> **Betal altid lidt** (redundante bits) **eller betal sjældent meget** (gensend). Hvad der bedst betaler sig, afhænger af fejlraten. Kraftig fejlkorrektion bruges, hvor gensendelse er dyr eller umulig.

---

## Mediet er delt: hvem må sende?

Alle fire teknologier løser samme spørgsmål, med to grundsvar:

| Strategi | Filosofi | Teknologier |
|---|---|---|
| **Contention**: send og håndtér konflikter | "Bed om tilgivelse" | **Ethernet** (CSMA/CD), **802.11** (CSMA/CA) |
| **Token-baseret**: vent på tilladelse | "Bed om lov" | **Token Ring**, **FDDI** |

## Ethernet: CSMA/CD

*(Deitel 16.8.1)*

Xerox PARC 1976, **IEEE 802.3**. **Carrier Sense Multiple Access with Collision Detection**: noderne tester via **transceivere**, om mediet er ledigt, før de sender.

**Hvorfor kollisioner alligevel sker:** transmission er ikke øjeblikkelig, så flere kan se mediet som frit og sende samtidig. Kolliderende frames korrumperes.

1. **Gør alle opmærksomme:** transceiverne **fortsætter med at sende** i en periode, så **alle** opdager kollisionen. Ellers kunne en anden tro, at dens frame kom korrekt frem
2. **Exponential backoff:** hver transceiver venter et **tilfældigt interval**, og **hver kollision på samme frame fordobler** det mulige interval

> **Hvorfor tilfældig?** Ellers ville noderne vente lige længe og **kollidere igen**, i det uendelige. Randomisering bryder symmetrien. Intervallet skal maksimere throughput og minimere nye kollisioner.

Flere kollisioner i træk er sjældne og tyder typisk på en konfigurations- eller hardwarefejl.

## Token Ring

*(Deitel 16.8.2)*

Kører på ring-netværk. **Token'et er en tom frame**, der cirkulerer.

1. Noden **venter** på den tomme frame
2. Den **ændrer én bit i headeren** (ikke længere tom) og skriver **besked + modtageradresse**
3. Hver node sammenligner sin adresse med framens; ingen match → send videre
4. Ved match kopieres beskeden, bitten ændres, og framen sendes videre
5. Når framen er **tilbage hos afsenderen**, kan den se, om beskeden blev modtaget, og sender den tomme frame videre

> **Kvitteringen er gratis:** framen skal alligevel hele vejen rundt. TCP må sende eksplicitte ACKs ([[Transport layer]]).

**Deadlock-risikoen:** fejler en station, mens den holder token'et, frigives det måske aldrig, og hele netværket **deadlocker**: én ressource, gensidig udelukkelse, ingen preemption. Protokollen har komplekse mekanismer til **detektion og recovery**.

**Fordelen:** transmissionstiden er **forudsigelig**. Token Ring er den næstmest udbredte arkitektur efter Ethernet.

| | **Ethernet** | **Token Ring** |
|---|---|---|
| Strategi | Contention | Vent på token |
| Kollisioner | Sker, håndteres med backoff | **Kan ikke ske** |
| Lav belastning | **Hurtig** | Langsommere (vent altid på token) |
| Høj belastning | Degraderer | Stabil |
| Forudsigelighed | Lav | **Høj** |
| Svaghed | Ydelse falder under pres | Tabt token → **deadlock** |

## FDDI

*(Deitel 16.8.3)*

**Fiber Distributed Data Interface** ligner Token Ring, men:
1. Kører over **fiber**: flere overførsler, højere hastighed, større afstande
2. Bygget på **to ringe**, den anden normalt **reserveret til backup**

Mens en station sender, cirkulerer **intet token**; bagefter genererer stationen et nyt. Er backup-ringen ikke nødvendig, bruges den til trafik i **modsat retning**.

> Ren **fault tolerance**: ringens svaghed (én node fejler → hele ringen fejler) afhjælpes med **redundans**, og redundansen laver nyttigt arbejde, når den ikke er nødvendig. Samme idé som replikaer, der også betjener læsninger.

## IEEE 802.11: CSMA/CA

*(Deitel 16.8.4)*

Trådløst, **Carrier Sense Multiple Access with Collision Avoidance**. Trådløse netværk er spontane og kan blokeres af bygninger, så det er **ikke garanteret, at hver enhed hører alle andre**. To enheder kan se luften som ledig og alligevel kollidere hos modtageren.

> **CD → CA:** i et kabel kan man høre kollisionen. I luften kan man ikke nødvendigvis høre den anden afsender, så man må **undgå** kollisioner.

**RTS/CTS:**
1. Afsenderen broadcaster **RTS (Request to Send)** med transmissionens **længde** og adresser
2. Er mediet ledigt, broadcaster modtageren **CTS (Clear to Send)**, også med længden
3. De to kommunikerer
4. **Alle andre**, der hørte CTS'en, **venter** den angivne tid

> CTS'en udsendes fra **modtagerens** position og reserverer luften dér, hvor en kollision ville gøre skade. Tiden **reserveres på forhånd**, som en lås på en kritisk sektion.

Sikkerheden på 802.11 (WEP/WPA) står i [[Sikre protokoller - TLS, IPsec og WiFi#WEP og WPA]].

## Oversigt

| Protokol | Standard | Medie | Adgangsmetode | Nøglemekanisme |
|---|---|---|---|---|
| **Ethernet** | IEEE 802.3 | Kabel | CSMA/**CD** | Exponential backoff |
| **Token Ring** | — | Ring | Token | Tom frame cirkulerer |
| **FDDI** | — | Fiber, **to ringe** | Token | Backup-ring, modsat retning |
| **802.11** | IEEE 802.11 | Trådløst | CSMA/**CA** | RTS/CTS-reservation |
