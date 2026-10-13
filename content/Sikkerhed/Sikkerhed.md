---
tags: [sikkerhed, moc, eksamen]
kilder: ["Deitel kap. 19", "Coulouris kap. 11"]
---

# Sikkerhed

Indgangen til sikkerhedsemnet: grundbegreberne, de krav en sikker løsning skal opfylde, og hvordan man designer et sikkert system. Detaljerne står i emnenoterne nedenfor.

## Noterne

| Note | Spørgsmålet den besvarer |
|---|---|
| [[Kryptografi]] | Hvordan skjuler man data? Symmetrisk vs. asymmetrisk, algoritmer, RSA, hybrid, steganografi |
| [[Hashing, digitale signaturer og MAC'er]] | Hvordan beviser man, at data er uændret og fra den rigtige afsender? |
| [[Certifikater og PKI]] | Hvem tilhører en public key? CA'er, X.509 vs. SPKI, tilbagekaldelse |
| [[Autentificering og Kerberos]] | **Hvem er du?** Passwords, biometri, Needham-Schroeder, Kerberos, SSO |
| [[Access control]] | **Hvad må du?** ACL vs. capabilities, RBAC, DAC/MAC, delegation, Orange Book |
| [[Trusler og angreb]] | Hvad angriber man med? Replay, MITM, virus/worms, DoS, buffer overflow |
| [[Forsvarsmekanismer]] | Firewalls, IDS, antivirus, patches, krypterede filsystemer, UNIX-casen |
| [[Sikre protokoller - TLS, IPsec og WiFi]] | Hvordan samles byggestenene til sikre kanaler på hvert lag? |

## Hvorfor overhovedet sikkerhed?

Fordi vi vil **dele ressourcer**. Ressourcer, der ikke deles, kan beskyttes ved at isolere dem. Sikkerhed er prisen for deling, og deling er hele grunden til at bygge distribuerede systemer *(Coulouris 11)*, se [[Distribuerede systemer]].

Udgangspunktet er sikkerhedsmodellen fra [[Fundamentale modeller]]: processer indkapsler ressourcer bag interfaces, **principals** (brugere eller processer) autoriseres til at bruge dem, og kommunikationen sker over et **delt netværk**, hvor en fjende kan læse, kopiere og indsætte beskeder med falsk afsender.

Også computere uden følsomme data skal sikres: de kan crashes, sprede virus eller bruges til identitetstyveri *(Deitel 19.1)*.

## Tre skel, der skal sidde fast

| Skel | Det ene | Det andet |
|---|---|---|
| **Security vs. protection** *(Deitel 19.1)* | **Security** = målet: forhindre uautoriseret adgang til ressourcer og information, udefra og indefra | **Protection** = mekanismerne, der skærmer ressourcer (access control, hukommelsesbeskyttelse) |
| **Policy vs. mechanism** *(Coulouris 11.1, Deitel 19.4.2)* | **Policy** = reglen ("gruppe X må læse dokumentklasse Y") | **Mechanism** = hvordan den håndhæves (kryptering, ACL'er, certifikater, låse) |
| **Autentificering vs. autorisation** | **Hvem er du?** → [[Autentificering og Kerberos]] | **Hvad må du?** → [[Access control]] |

> **En lås gør ikke bygningen sikker, hvis der ingen regel er for, hvornår døren skal låses.** Mekanismer sikrer ikke noget i sig selv; de håndhæver en policy. Uden skellet kan man ikke afgøre, om et system er sikkert *(Coulouris 11.1)*.

**Kryptografi ≠ sikkerhed.** Kryptografi er grundlaget for de fleste mekanismer, men sikkerhed starter med en **trusselsliste**.

Coulouris bruger faste navne: **Alice, Bob** (deltagere), **Carol, Dave** (3. og 4. part), **Eve** (eavesdropper), **Mallory** (ondsindet angriber), **Sara** (en server).

## Kravene til en sikker transaktion

| Krav | Spørgsmålet | Løses typisk af |
|---|---|---|
| **Privacy** (secrecy) | Er data opsnappet eller givet videre? | Kryptering → [[Kryptografi]] |
| **Integrity** | Er data **ændret** undervejs? | Hash, MAC, signatur → [[Hashing, digitale signaturer og MAC'er]] |
| **Authentication** | Er afsender og modtager **dem, de siger**? | Private key, signatur, certifikat |
| **Authorization** | Hvad må brugeren, givet brugerens **credentials** (identitet + bevis)? | [[Access control]] |
| **Nonrepudiation** | Kan det **juridisk bevises**, at en besked blev sendt/modtaget? | Signatur + time stamping |
| **Availability** | Kører systemet **kontinuerligt**? | Forsvar mod DoS |

Kilde: de fem første er Deitels krav *(Deitel 19.7)*; availability tilføjes samme sted.

> ⚠️ Deitels kapitelresumé (s. 923) siger fejlagtigt, at nonrepudiation handler om, at netværket kører kontinuerligt. Det er **availability**.

Kryptografi har tre roller *(Coulouris 11.2.2)*: (1) **secrecy og integrity** (integritet kræver også redundant info som en checksum), (2) **authentication** (lykkes dekryptering med en nøgle kun to kender, ved man hvem der sendte), (3) **digitale signaturer** (bevis over for en *tredjepart*).

### Eksempel: webkøb og netbank

*(Coulouris 11.1.2)*
1. **Autentificér sælgeren** over for køberen
2. Hold kortoplysninger **hemmelige og uændrede** på vej til sælgeren
3. Lever downloadbare varer **uændrede og uden afsløring**
4. (Bank) **Autentificér kontohaveren** og sørg for **non-repudiation**

> **Asymmetrien:** ved køb skal **sælgeren** autentificeres, men køberens identitet er sjældent nødvendig. Det er netop det, TLS typisk gør: kun serveren har et certifikat.

**Skalakravet:** man skal kunne handle sikkert **uden tidligere kontakt og uden tredjepart**. Det udelukker ren secret-key-kryptografi og peger mod public-key. **Micro-transactions** kræver ekstremt billige mekanismer, så en bank kan ikke involveres i hver betaling.

## Design af sikre systemer

*(Coulouris 11.1.3)*

At designe et sikkert system er som at skrive et **fejlfrit program**: ingen metode garanterer det.

1. Lav en **liste over trusler** (måder policyen kan brydes på), se [[Trusler og angreb]]
2. Vis, at **hver** trussel forhindres af mekanismerne (helst med et **logisk bevis**, fx BAN-logik)
3. Da ingen liste er udtømmende: **audit** med en sikker **security log** (principal, operation, objekt, timestamp)

**Sikkerhed er en afvejning af omkostninger mod trusler:** mekanismer koster regnekraft og netværk, og forkert specificerede mekanismer kan udelukke legitime brugere.

**Internettet er usikkert,** fordi sikkerhed ikke var en prioritet, da det blev designet, og UNIX' grunddesign ligger før netværkenes tid. Cheswick og Bellovin fandt 42 alvorlige svagheder i udbredte internetsystemer. Lektien: **sikkerhed skal tænkes ind fra designstart.**

### De seks worst-case-antagelser (eksamensstof)

| Antagelse | Konsekvens for designet |
|---|---|
| **Interfaces er eksponerede** | Alle kan sende en besked til ethvert interface, fordi de *skal* være åbne for nye klienter |
| **Netværk er usikre** | Afsendere kan forfalskes, adresser kan **spoofes** |
| **Begræns levetid og omfang af enhver hemmelighed** | Jo længere og bredere en nøgle bruges, jo større risiko. Derfor udløber Kerberos-tickets, certifikater og nøgler |
| **Algoritmer og kode er kendt af angriberen** | **Publicér algoritmerne**, hold kun **nøglerne** hemmelige. Det modsatte af *restricted algorithms* og *security through obscurity* |
| **Angribere har store ressourcer** | Antag de største computere i systemets levetid **plus et par størrelsesordener** |
| **Minimér den betroede base** | **Trusted computing base** = alt, sikkerheden afhænger af. Gør den lille |

## Den røde tråd

**Tre spørgsmål, der bygger ovenpå hinanden** *(Deitel 19)*:

| Spørgsmål | Svar |
|---|---|
| **Hvem er du?** | [[Autentificering og Kerberos]] |
| **Hvad må du?** | [[Access control]] |
| **Hvordan kommunikerer vi sikkert med en, vi ikke kan se?** | [[Kryptografi]] → [[Hashing, digitale signaturer og MAC'er\|signaturer]] → [[Certifikater og PKI\|certifikater]] → [[Sikre protokoller - TLS, IPsec og WiFi\|TLS/IPsec]] |

**Nøgledistribution som en trappe**, hvor hvert trin løser det forriges problem *(Coulouris 11.2)*:

| Trin | Løser | Men efterlader |
|---|---|---|
| **Delt secret key** | Hemmelighed og integritet | Hvordan deles nøglen? Replay? |
| **Authentication server** (Needham-Schroeder/Kerberos) | Nøgledistribution **i én organisation** | Serveren skal kende alles nøgler. Duer ikke på internettet |
| **Public keys** (hybrid) | Nøgledistribution **uden forudgående kontakt** | Hvem tilhører en public key? (man-in-the-middle) |
| **Certifikater** | Binder nøgle til identitet | Hvem stoler vi på som rod? Tilbagekaldelse? |
| **TLS** | Samler det hele i en forhandlingsbar protokol | (WEP viser, hvad der sker, når man springer trinene over) |

> **Vigtigste enkeltindsigt:** symmetrisk og asymmetrisk kryptografi er **komplementære**. Public-key er langsom, men løser nøgleudvekslingen; secret-key er hurtig, men kræver en delt nøgle. Kombinationen (**digital envelope** / **hybrid protocol**) er grundlaget for TLS, IPsec og PGP.

### Gennemgående temaer

| Tema | Hvor det optræder |
|---|---|
| **Centralisering = stærkere, men single point of failure** | KDC · SSO-server · CA-hierarkiet · access control matrix |
| **Sikkerhed koster performance** | Nøglelængde · 3DES · public-key vs. secret-key · WEP på svage enheder |
| **Begræns levetiden af hemmeligheder** | Udløb af nøgler · Kerberos-tickets · certifikater · password aging · delegation |
| **Mennesket er det svage led** | Nedskrevne passwords · upatchede systemer (Slammer) · WEP slået fra · lækkede private keys |
| **Hver mekanisme har en bagside** | Lange passwords → på papir · kontolåsning → admin låses ude · setuid → superuser |

### Bøgernes vinkler
Deitel giver **bredden** (angreb, forsvar, OS-mekanismer, produkter); Coulouris giver **dybden** (protokoller og hvorfor de er designet sådan, RSA regnet ud, Kerberos præcist). Hvor de er uenige, er det markeret med ⚠️ i noterne.
