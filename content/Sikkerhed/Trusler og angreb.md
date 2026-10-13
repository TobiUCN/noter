---
tags: [sikkerhed, trusler, angreb, replay, man-in-the-middle, virus, worm, dos, buffer-overflow, eksamen]
kilder: ["Deitel 19.5", "Coulouris 11.1.1", "OWASP Top 10:2025"]
---

# Trusler og angreb

Del af [[Sikkerhed]]. Trusselslisten er udgangspunktet for at designe et sikkert system. Forsvaret står i [[Forsvarsmekanismer]].

## Tre klasser af trusler

*(Coulouris 11.1.1)*

| Trussel | Betyder |
|---|---|
| **Leakage** | Uautoriserede **får fat i** information |
| **Tampering** | Uautoriseret **ændring** af information |
| **Vandalism** | **Forstyrrelse** af systemet **uden gevinst** for gerningsmanden |

## Angreb på kommunikationskanalen

*(Coulouris 11.1.1)*

| Angreb | Hvordan | Modtræk |
|---|---|---|
| **Eavesdropping** | Kopiér beskeder uden tilladelse | Kryptering → [[Kryptografi]] |
| **Masquerading** | Send/modtag med **en andens identitet** | Autentificering → [[Autentificering og Kerberos]] |
| **Message tampering** | Opsnap og **ændr** beskeder | MAC'er / signaturer → [[Hashing, digitale signaturer og MAC'er]] |
| **Replaying** | Gem en opsnappet besked og **send den igen** senere | **Nonces / timestamps** |
| **Denial of service** | Oversvøm en kanal eller ressource | Svært, se nedenfor |

> **Replay er det lumske angreb:** det virker **selv på autentificerede og krypterede beskeder**. Mallory behøver ikke kunne læse "betal 1000 kr." for at sende den igen. Derfor bruger Needham-Schroeder og Kerberos nonces.

**Man-in-the-middle** er en form for tampering: angriberen opsnapper **den allerførste besked** i en nøgleudveksling og indsætter sine egne nøgler, så angriberen kan dekryptere og re-kryptere alt. Forsvaret er [[Certifikater og PKI|certifikater]].

## Overblik over angreb på systemer

*(Deitel 19.5)*

| Angreb | Mål | Kerneidé |
|---|---|---|
| **Cryptanalysis** | Krypteringen | Find nøglen uden at have den |
| **Virus / worm** | Filer og systemer | Selvreplikerende kode |
| **Denial of service** | **Availability** | Gør systemet ude af stand til at betjene legitime brugere |
| **Software exploitation** | Applikationer | Udnyt fejl, fx buffer overflow |
| **System penetration** | Hele systemet | Det **resultat**, de andre angreb ofte fører til |

---

## Cryptanalysis

*(Deitel 19.5.1)*
Forsøg på at dekryptere **uden nøglen**, typisk ved at analysere algoritmen for **statistiske sammenhænge mellem nøglebits og ciphertext-bits**. Forsvar: god **key management** og **udløbsdatoer på nøgler** (se [[Kryptografi#Key management|Key management]]).

## Viruses og worms

*(Deitel 19.5.2)*

| | **Virus** | **Worm** |
|---|---|---|
| Spreder sig via | Inficerede filer (vedhæftninger, spil) | **Netværket** |
| Kræver brugerhandling | Typisk ja | **Sjældent** |
| Skal hæfte sig til en fil | **Ja** | **Nej** |

| Virustype | Kendetegn |
|---|---|
| **Boot sector virus** | Inficerer boot-sektoren, så den **loader med OS'et** |
| **Transient virus** | Kun aktiv, **mens programmet kører** |
| **Resident virus** | Ligger i hukommelsen **til maskinen slukkes** |
| **Logic bomb** | Udløser sin **payload**, når en betingelse opfyldes. **Time bomb** = betingelsen er et tidspunkt |

- **Trojan horse:** skjuler sig i, eller udgiver sig for, et legitimt program
- **Back-door program:** resident virus, der giver angriberen fuld, uopdaget adgang (fx keylogging)

### Cases

| Case | Mekanisme | Lektie |
|---|---|---|
| **Melissa** (1999) | Word-dokument via mail → sender sig selv til 50 fra adressebogen | Eksponentiel spredning via tillidsforhold |
| **ILOVEYOU** (2000) | "Kærlighedsbrev" → sender til hele adressebogen, ødelægger filer | Vær mistænksom, også over for kendte afsendere |
| **Sapphire/Slammer** (2003) | Worm i SQL Server 2000. **Én UDP-pakke på 404 bytes**, tilfældig scanning af IP'er. Fordoblede antal inficerede hver 8,5 s; de fleste ramt inden for 10 min | Se nedenfor |

> **Hvorfor var Slammer så hurtig?** Code Red brugte **TCP**, som kræver et three-way handshake pr. offer. Slammer brugte **UDP**: ingen forbindelse, bare send ([[Transport layer]]). Slammer havde ingen ondsindet payload; skaden kom alene fra netværksmætning. Og der fandtes en **patch 6 måneder før**: problemet var, at den ikke blev installeret.

## Denial of Service

*(Deitel 19.5.3)*

| Variant | Hvordan |
|---|---|
| **Flooding** | Mætter netværk/server med trafik |
| **Routing table-angreb** | Ændrer routingtabeller, så trafik omdirigeres |
| **DNS-angreb** | Ændrer adressen bag et domænenavn, så brugere sendes til et falsk site ([[DNS]]) |
| **Distributed DoS (DDoS)** | Flooding fra **mange maskiner** samtidig, typisk inficerede computere |

**Hvorfor er DDoS svært at stoppe?** Det er svært at skelne legitime requests fra angrebstrafik, og angrebet kommer ikke fra angriberens egen maskine. En flod af beskeder overvælder **ethvert enkelt forsvarspunkt**, så afhjælpning skal ske længere opstrøms *(Coulouris 11.2.6)*.

Februar 2000 lukkede DDoS Yahoo!, eBay, CNN og Amazon. DoS rører ikke data, men koster stadig dyrt.

## Buffer overflow

*(Deitel 19.5.4)*
Et program modtager **mere input, end der er plads til**, og det overskydende skrives ind i nabobuffere. Et velkonstrueret overflow kan **overskrive returadressen på stakken**, så angriberens kode kører **med applikationens rettigheder**.

**Forsvar:** strenge buffergrænser i applikationen, og **ikke-eksekverbare stack-segmenter** i OS'et. Forsvaret er reelt **hukommelsesbeskyttelse**: protection-mekanismerne fra memory management er også sikkerhedsmekanismer.

OWASP tilføjer, at det bedste forsvar er et **memory-safe sprog** (Java, C#, Rust). Ellers kan man bruge ASLR, DEP og stack canaries *(OWASP X02)*. Angreb på webapplikationer (injection, broken access control osv.) står i [[OWASP Top 10]].

## System penetration

*(Deitel 19.5.5)*
**Et vellykket brud af en uautoriseret ekstern bruger.** Sjældent målet i sig selv, men fundamentet for datatyveri, manipulation og crash. Typiske indgange: Trojan horse, back door, upatchede webservere, browsere.

| | Web defacing | DNS-angreb |
|---|---|---|
| Hvad ændres | **Indholdet** på det rigtige site | **Adressen** bag domænenavnet |
| Brugeren havner | På det rigtige (ændrede) site | På et **andet** site |

**CERT/CC** (Carnegie Mellon) indsamler hændelsesrapporter og udgiver vejledning. En *hacker* er en dygtig programmør; den, der bryder ind ondsindet, er korrekt en **cracker**.

---

## Særlige trusler i distribuerede systemer

*(Coulouris 11.1.1)*

**Mobile code** (fx Java): kode hentes fra en fjernserver og køres lokalt. Javas **sandbox**:
- Hver applikation får sin egen **security manager**, som ikke kan udskiftes
- Applets må typisk ikke tilgå lokale filer, printere eller sockets
- **Downloadede klasser holdes adskilt** fra lokale
- **Bytecode verificeres**

Alligevel giver mobile code-sikkerhed **mindre tillid** end kanalsikkerhed, fordi et kørselsmiljø har så mange muligheder for fejl.

**Information leakage:** selv **eksistensen** af beskeder kan afsløre noget (mange beskeder til én aktiemægler → stor handel). Se Bell–LaPadula i [[Access control]].
