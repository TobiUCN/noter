---
tags: [sikkerhed, kryptografi, symmetrisk, asymmetrisk, rsa, aes, cbc, hybrid, steganografi, eksamen]
kilder: ["Deitel 19.1–19.2, 19.8, 19.11", "Coulouris 11.2.1, 11.3, 11.5"]
---

# Kryptografi

Del af [[Sikkerhed]]. Fundamentet for resten: [[Hashing, digitale signaturer og MAC'er|signaturer]], [[Certifikater og PKI|certifikater]], [[Autentificering og Kerberos|Kerberos]] og [[Sikre protokoller - TLS, IPsec og WiFi|TLS/IPsec]] bygger på det, der står her.

## Grundbegreber

| Term | Betydning |
|---|---|
| **Cipher / cryptosystem** | Den matematiske algoritme, der krypterer |
| **Key** | Input til cipheren. Forskellige nøgler giver forskellig ciphertext |
| **Plaintext → ciphertext** | Ukrypteret → krypteret data |
| **Restricted algorithm** | Sikkerheden hviler på, at **selve algoritmen er hemmelig** |

Formelt *(Coulouris 11.3)*: kryptering er `E(K, M) = {M}K`, hvor **nøglen vælger én funktion ud af en stor familie**. Symmetrisk: `D(K, E(K, M)) = M` (samme nøgle). Asymmetrisk: `D(Kd, E(Ke, M)) = M` (forskellige nøgler).

### Notation

*(Coulouris 11.2)*

| Symbol | Betydning |
|---|---|
| `KA`, `KB` | Alices / Bobs secret key |
| `KAB` | Secret key **delt** mellem Alice og Bob |
| `KApriv` / `KApub` | Alices private / public key |
| `{M}K` | M **krypteret** med K |
| `[M]K` | M **signeret** med K |

### Klassiske ciphers

*(Deitel 19.2)*
- **Substitution:** hvert bogstav erstattes af et andet. **Caesar cipher** = forskyd 3 pladser ("security" → "vhfxulwb")
- **Transposition:** bogstavernes **rækkefølge** byttes om ("security" → "scrt euiy")
- Kombinationen er **mere robust** end hver for sig

### Hvorfor restricted algorithms ikke duer
De kræver, at **alle** parter holder algoritmen hemmelig, og én lækage kompromitterer hele systemet. Moderne kryptografi gør det modsatte: **algoritmen er offentlig, kun nøglen er hemmelig**, så en kompromitteret nøgle kan udskiftes uden at skifte algoritme *(Deitel 19.2)*. Det er worst-case-antagelsen *"algorithms and program code are available to attackers"* fra [[Sikkerhed#De seks worst-case-antagelser (eksamensstof)|Sikkerhed]].

### One-way og trap-door functions

*(Coulouris 11.3)*

| Begreb | Definition | Bruges i |
|---|---|---|
| **One-way function** | `F(M)` er let at beregne, `F⁻¹` er urealistisk svær | **Al** kryptering |
| **Trap-door function** | One-way, **men med en hemmelig udgang**: inversen er let, *hvis* man kender hemmeligheden | **Public-key**. Den private key er "lemmen" |

### Nøglelængde: sikkerhed vs. performance
For en god symmetrisk algoritme er det mest effektive generelle angreb **brute force**: med **N bits** kræver det i gennemsnit **2^(N−1)** forsøg *(Coulouris 11.3)*. Hver ekstra bit **fordobler** arbejdet, så 128 bit vs. 56 bit er ikke "dobbelt så sikkert", men **2^72 gange** sværere. Til gengæld giver længere nøgler **langsommere kryptering** *(Deitel 19.2)*, og den trade-off går igen overalt (3DES, public-key, WEP).

---

## Secret-key (symmetrisk) kryptografi

**Samme nøgle** krypterer og dekrypterer. Billig.

### Problemerne

*(Deitel 19.2.1)*
1. **Key exchange:** nøglen skal udveksles sikkert, *før* man kan kommunikere sikkert (hønen og ægget)
2. **Skalerer ikke:** én nøgle **pr. modtager**
3. **Ingen autentificering:** begge har samme nøgle, så man kan ikke se, hvem af dem der lavede beskeden
4. **Replay** *(Coulouris 11.2, scenarie 1)*: selv uden nøglen kan Mallory kopiere og gensende en krypteret "betal X"-besked

### Key Distribution Center (KDC)

*(Deitel 19.2.1)*
En central instans, der deler en **unik hemmelig nøgle med hver bruger**. KDC genererer en **session key** til én transaktion og sender den til begge parter, krypteret med hver parts egen KDC-nøgle.

| Fordel | Ulempe |
|---|---|
| Færre fysiske nøgleleverancer. Ny nøgle pr. kommunikation | **Single point of failure:** kompromitteres KDC'en, er hele netværket kompromitteret |

KDC-idéen er præcis det, **Needham-Schroeder og Kerberos** bygger på → [[Autentificering og Kerberos]].

### Block ciphers og CBC

*(Coulouris 11.3)*
**Block cipher:** opdel beskeden i blokke af fast størrelse (typisk 64 bit), **pad** den sidste, og kryptér hver blok.

**Svagheden:** blokke krypteres **uafhængigt**, så **ens plaintext-blokke giver ens ciphertext-blokke**, og mønstre kan genkendes.

**Cipher Block Chaining (CBC):** hver plaintext-blok **XOR'es med den forrige ciphertext-blok**, før den krypteres. Det virker, fordi XOR er sin egen invers:
```
C[i] = E(K, P[i] XOR C[i-1])
P[i] = D(K, C[i]) XOR C[i-1]
```
- **Initialization vector (IV):** et forskelligt stykke plaintext forrest (fx et timestamp), så **samme besked** til to modtagere ikke giver samme ciphertext
- **Kræver pålidelig transport:** mistes én blok, kan ingen efterfølgende dekrypteres

### Stream ciphers

*(Coulouris 11.3)*
Til **realtidsdata** (fx telefoni), hvor data kommer i små stykker, og det ville være spild at padde hvert til 64 bit. En **keystream generator** laver en lang bitsekvens (typisk en random number generator med aftalt startpunkt, krypteret med en block cipher), og **ciphertext = plaintext XOR keystream**.

> Keystreamen må **aldrig genbruges**. Det er præcis det, WEP gjorde forkert → [[Sikre protokoller - TLS, IPsec og WiFi#WEP og WPA|WEP]].

| | Block cipher (CBC) | Stream cipher |
|---|---|---|
| Enhed | Blokke | Bits/bytes |
| Tab af data | **Ødelægger resten** | Tolereres |
| Egnet til | Pålidelige forbindelser, filer | Realtid, lyd, video |

### Designprincipper: confusion og diffusion (Shannon)

| Princip | Hvordan | Formål |
|---|---|---|
| **Confusion** | Kombinér hver blok med nøglen via XOR, cirkulær shift | Slør sammenhængen mellem M og {M}K, så frekvensanalyse slås ud (Enigma brugte enkelt-bogstavsblokke og blev knækket statistisk) |
| **Diffusion** | **Transponér** dele af hver blok | Spred gentagelser og redundans ud. Med CBC over hele teksten |

### Algoritmerne

| Algoritme | Nøgle | Blok | Kendetegn | Status |
|---|---|---|---|---|
| **TEA** (Cambridge) | 128 bit | 64 bit | Få linjer C, 32 runder med addition, XOR og shifts | Til illustration *(Coulouris)* |
| **DES** (IBM, 1977) | **56 bit** | 64 bit | 16 runder, designet til hardware | **Usikker**: knækket 1997 |
| **3DES** | 2–3 nøgler (112 bit styrke) | 64 bit | `E(K1, D(K2, E(K1, M)))` | Sikker, men **tre gennemløb = langsom** |
| **IDEA** | 128 bit | 64 bit | Samme funktion til kryptering og dekryptering | ~3× hurtigere end DES |
| **RC4** (Rivest) | op til 256 byte | **Stream** | ~10× hurtigere end DES | Svaghed fundet 2001, hvilket fældede WEP |
| **AES** (Rijndael, 2000) | 128/192/256 | 128/192/256 | Valgt for sikkerhed, performance og lavt hukommelsesforbrug | Standarden, erstatter DES |

**DES-cracket (1997)** *(Coulouris 11.3.1)*: op til 14.000 maskiner koordineret af én server knækkede nøglen på ca. 12 uger efter at have prøvet ~25 % af nøglerummet. I 1998 byggede EFF en maskine, der klarer det på ca. 3 dage. Angrebet var i sig selv et **distribueret system**: "angribere har store ressourcer" er ikke teori.

---

## Public-key (asymmetrisk) kryptografi

Diffie og Hellman (1976), opfundet **for at løse key exchange-problemet** *(Deitel 19.2.2)*. To **omvendt relaterede** nøgler: en **private key** (hemmelig) og en **public key** (distribueres frit). Det, den ene krypterer, kan kun den anden dekryptere, og omvendt. Sikkerheden hviler på en trap-door function. **100–1000 gange dyrere** end secret-key *(Coulouris 11.2.1)*, så den bruges kun i starten af en session.

### Hvilken nøgle giver hvad?

| Afsender krypterer med … | Modtager dekrypterer med … | Opnår | Opnår **ikke** |
|---|---|---|---|
| **Modtagerens public key** | Modtagerens private key | **Privacy** | Autentificering af afsender |
| **Afsenderens private key** | Afsenderens public key | **Autentificering af afsender** | Fortrolighed (alle kan dekryptere) |
| **Begge** | Begge | Begge dele | |

> **Huskeregel:** *Krypter med en public key for at skjule. Krypter med en private key for at bevise, hvem du er.* En signatur skal laves med en hemmelighed, kun underskriveren kender, og kunne verificeres af alle *(Coulouris 11.4.1)*.

**Svagheden:** hvordan ved man, at en public key **faktisk tilhører** den, den påstår? → [[Certifikater og PKI]].

### RSA, trin for trin

*(Coulouris 11.3.2)*
RSA (Rivest, Shamir, Adleman, MIT 1977) er den mest brugte public-key-algoritme *(Deitel 19.2.2)*.

| Trin | Generelt | Eksempel |
|---|---|---|
| 1 | Vælg to store primtal P, Q (> 10¹⁰⁰) | P = 13, Q = 17 |
| | N = P × Q | N = 221 |
| | Z = (P−1)(Q−1) | Z = 192 |
| 2 | Vælg d **indbyrdes primisk** med Z | d = 5 |
| 3 | Find e, så **e × d ≡ 1 (mod Z)**: første tal i Z+1, 2Z+1, … der er deleligt med d | 193 nej, **385 = 5 × 77** → e = 77 |
| | Bloklængde k, så 2^k < N | k = 7 |

- **Kryptering:** `E(e, N, M) = M^e mod N`
- **Dekryptering:** `D(d, N, c) = c^d mod N`
- Public key `<e, N>`, private key `<d, N>`

*Regnet eksempel (ikke i bogen):* M = 10 → c = 10⁷⁷ mod 221 = **147** → 147⁵ mod 221 = **10** ✓

> **Hvorfor sikkert?** For at finde d skal man kende P og Q, og dem får man kun ved at **faktorisere N**. Multiplikation er let, faktorisering er urealistisk. Det er trap-door-funktionen. Forudsætter, at der ikke findes en hurtigere faktoriseringsalgoritme.

- **Nøglestørrelser:** 512 bit er for svagt; RSA anbefalede mindst 768, og 2048 bruges
- **Chosen plaintext attack:** public key'en er offentlig, så angriberen kan kryptere gæt og sammenligne. Forsvar: beskeder **længere end nøglen**

**Elliptic curve-algoritmer:** sikkerheden hviler ikke på faktorisering. **Kortere nøgler giver samme sikkerhed**, velegnet til mobile enheder.

---

## Symmetrisk vs. asymmetrisk

| | Secret-key | Public-key |
|---|---|---|
| Nøgler | 1 delt | Par |
| Hastighed | **Hurtig** | **Langsom** (100–1000×) |
| Key exchange | **Problemet** | **Løsningen** |
| Autentificering | Nej | Ja (via private key) |
| Typisk brug | Bulk-data | Udveksle secret keys, signaturer |

## Hybrid: digital envelope

De to typer er **komplementære**. Deitel kalder kombinationen **digital envelope** *(Deitel 19.8)*, Coulouris kalder den en **hybrid cryptographic protocol** *(Coulouris 11.3.3)*:

1. Kryptér **beskeden** med en ny **secret key** (hurtigt)
2. Kryptér **secret key'en** med **modtagerens public key**
3. Send begge samlet
4. Modtager dekrypterer secret key'en med sin private key og derefter beskeden

Brug den dyre asymmetriske kryptering på det **lille** (en nøgle) og den billige symmetriske på det **store** (data). Det er sådan TLS, IPsec og PGP virker.

**Man-in-the-middle** *(Coulouris 11.2, scenarie 3)*: Mallory opsnapper Alices forespørgsel efter Bobs public key og svarer med sin egen. Forsvar: Bobs nøgle skal komme i et **certifikat**, signeret med en nøgle Alice har fået på en sikker måde → [[Certifikater og PKI]].

## Key management

> **De fleste brud skyldes dårlig key management** (stjålne private keys), **ikke kryptoanalyse.** Når nøglerne er lange nok, er det lettere at stjæle nøglen end at knække den *(Deitel 19.8.1)*.

- **Key generation** skal vælge **tilfældigt fra et stort rum**. En generator, der kun bruger en lille delmængde, gør brute force realistisk uanset nominel nøglelængde. Det gælder især open source-krypto, hvor genereringsteknikken er offentlig *(Deitel 19.12)*
- **Udløbsdatoer på nøgler:** jo længere en nøgle bruges, jo mere ciphertext har angriberen at analysere *(Deitel 19.5.1)*

## Kryptografi i praksis

*(Coulouris 11.5)*
- **Performance:** websider kan krypteres symmetrisk på få ms. RSA-1024 signering ≈ 4,75 ms, verifikation ≈ 0,18 ms. Algoritmerne påvirker næsten ikke HTTPS' oplevede hastighed. Signering ~25× dyrere end verifikation passer godt: én server signerer, mange klienter verificerer
- **Politik:** USA klassificerede krypto-software som **våben** med eksportbegrænsning til **40-bit nøgler** (årsagen til WEP's korte nøgler). Reglerne forhindrede ikke spredningen, men skadede amerikanske virksomheder. Lempet i januar 2000
- **PGP** (Zimmermann 1991): krypterer mail og filer og laver signaturer. **Hybrid**: RSA til nøgleudveksling og autentificering, IDEA/3DES til indholdet. Bygger på et **web of trust** → [[Certifikater og PKI#Web of trust og SPKI|Certifikater og PKI]]

---

## Steganografi

*(Deitel 19.11)*

**"Covered writing"**: at **skjule information i anden information** (billede, lyd, tekst).

| | Kryptografi | Steganografi |
|---|---|---|
| Ved tredjepart, at der er en hemmelig besked? | **Ja**, men kan ikke læse den | **Nej** |
| Er beskeden ulæselig? | Ja | Ofte ikke |

- *Tekst:* "**B**URIED **U**NDER **Y**ARD" = "BUY" (første bogstav i hvert ord)
- *Billede:* i et gråtonebillede erstattes **den mindst betydende bit** i hver pixel med én bit af beskeden. Hver pixel ændres højst én nuance

**Digital watermarking:** den vigtigste anvendelse. Ejeren gemmer et synligt eller usynligt mærke i ubrugte dele af filen som **bevis for ejerskab** (intellectual property). Musikindustrien kan lægge mærker på frekvenser, mennesker ikke kan høre.
