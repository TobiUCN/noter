---
tags: [netværk, application-layer, http, ftp, url, socket, mime, www, rest, eksamen]
kilder: ["Deitel 16.5", "Coulouris 1.6"]
---

# Application layer og WWW

Del af [[Netværk]], øverste lag i [[TCP-IP protocol stack]].

> Applikationslaget giver et **veldefineret interface**, så applikationer på forskellige computere kan tale sammen: hente en webside, sende en mail, kalde en fjern procedure *(Deitel 16.5)*. Laget bestemmer **hvordan processer interagerer**, altså semantikken; lagene under bestemmer, hvordan bittene kommer frem.

Almindelige protokoller: **HTTP**, **FTP**, **SMTP** (mail), **DNS** (navneopslag, se [[DNS]]), **SSH**.

## URI, URL og socket

| Begreb | Hvad det er |
|---|---|
| **URI** | Et **navn**, der refererer til en ressource på en fjern host |
| **URL** | URI'er, der tilgår ressourcer via almindelige protokoller som HTTP eller FTP |
| **Socket** | En **softwarekonstruktion**, der repræsenterer **ét endepunkt** af en forbindelse |

En socket er en **ressource, kernen administrerer**, ligesom en fildeskriptor. Det gør netværk til et OS-emne. Navne og URI/URL/URN som begreber står i [[Navne og navneopløsning]].

### Anatomi af en URL
```
http://www.deitel.com:80/index.html
└─┬─┘  └──────┬──────┘ └┬┘ └───┬────┘
protokol    host      port    path
```

Generelt har en URL formen `scheme : scheme-specific-identifier` *(Coulouris 1.6)*. **Scheme** (`http`, `mailto`, `ftp`, `tel` …) er det, der gør webbet **åbent** for nye ressourcetyper. En HTTP-URL:

```
http:// servername [:port] [/pathName] [?query] [#fragment]
```

| Del | Betydning |
|---|---|
| **servername** | DNS-navn (fully qualified), oversættes til IP via [[DNS]] |
| **port** | Hvilken **socket** beskeden afleveres til. Default 80 |
| **pathName** | Ressourcens placering. Mangler den, gives standardsiden |
| **query** | Fx data fra en formular (`?q=obama`) |
| **fragment** | En del af ressourcen; browseren søger efter den, **efter** hele filen er hentet |

### Well-known ports
**IANA** tildeler faste porte til almindelige protokoller, så porten kan udelades: HTTP = **80**, FTP = **20** (data) og **21** (kontrol).

> **IP-adressen finder maskinen, porten finder processen.** Uden porte kunne en host kun køre én netværksservice. Porten er OS'ets multiplexnøgle over ét netværksinterface.

---

## HTTP

**Hypertext Transfer Protocol** bruges typisk til HTML, men kan overføre mange formater via **MIME** *(Deitel 16.5.1)*.

| Træk | Beskrivelse |
|---|---|
| **Request-reply** | Klienten sender en request (metode + URI); serveren svarer med en statuskode (fx `404 Not Found`) og evt. ressourcen. Samme paradigme som RPC/RMI ([[Arkitekturmodeller]]) |
| **Metoder** | **GET** (hent), **POST** (send data), **PUT** (opret), **DELETE** (slet) |
| **Content types** | Typen angives som **MIME type** (`text/html`, `image/gif`, `application/zip`). MIME har fem hovedtyper: text, image, audio, video og **application** (binære filer) |
| **Én ressource pr. request** | En side med 9 billeder kræver **10** requests. Browsere sender flere samtidig |
| **Simpel access control** | Som standard kan alle hente publicerede ressourcer; serveren kan sende en **challenge** (fx password) |

(*Coulouris 1.6*.) Kun **browseren fortolker HTML**; serveren fortæller bare, hvilken content type den returnerer.

## FTP

*(Deitel 16.5.2)*

FTP bruger **to forbindelser**:

| Port | Bærer |
|---|---|
| **21** | **Kontrolinformation** |
| **20** | Selve **dataene** |

> **Hvorfor splitte?** Kontrolkanalen kan reagere på kommandoer (fx afbryd), mens datakanalen er optaget af en stor overførsel. Separation of concerns på protokolniveau.

| Kommando | Funktion |
|---|---|
| `CWD` / `CDUP` / `PWD` | Skift mappe / gå op / udskriv sti |
| `LIST` | Vis mappens indhold |
| `RETR` / `STOR` | Download / upload |
| `DELE` | Slet fil |
| `QUIT` | Afslut |

Kommandoerne er **filsystemoperationer over netværket**, den transparens distribuerede filsystemer stræber efter.

> **Hvorfor bruger HTTP og FTP TCP og ikke UDP?** En manglende byte i en fil eller en HTML-side er ikke acceptabel, og ingen af dem er tidskritiske ([[Transport layer]]).

---

## World Wide Web

*(Coulouris 1.6)*

Startede på **CERN i 1989** som en måde at udveksle dokumenter mellem fysikere. Nøglefeature: **hypertekst** med links mellem dokumenter. Webbet **er ikke** internettet, men en service oven på det.

**De tre kerneteknologier:** **HTML** (indhold og layout, med tags), **URL** (identificerer ressourcer) og **HTTP** + klient-server-arkitekturen.

**Webbet er åbent** på to måder (se openness i [[Udfordringer i distribuerede systemer]]): frit publicerede **standarder**, og nye **ressourcetyper** kan tilføjes via plug-ins. Det har udviklet sig fra dokumenter til services uden at ændre grundarkitekturen.

### Dynamiske sider
Ved formularer peger URL'en på et **program**, ikke en fil. Parametre sendes i **query** (GET) eller i request-body (POST). Et program, webserveren kører for at generere indhold, kaldes et **CGI-program**. Forskellen på statisk og dynamisk indhold er **transparent for browseren**.

**Downloaded code** kører i browseren i stedet:
- **JavaScript:** øjeblikkelig feedback uden rundtur til serveren
- **AJAX:** henter data **asynkront**, uafhængigt af brugerens handlinger ([[Arkitekturmodeller#AJAX]])
- **Applets:** Java-programmer, browseren downloader og kører

### Web services og REST
Andre programmer end browsere kan være klienter. **HTML er utilstrækkeligt** til det, fordi det er bundet til præsentation. **XML** er **selvbeskrivende** (navne, typer, struktur) og derfor portabelt mellem applikationer.

> **REST** (Fielding 2000): enhver ressource har en URL og svarer på **det samme lille sæt operationer** (GET, POST, PUT, DELETE), selvom behandlingen varierer. Bagsiden af udvideligheden kan være manglende robusthed.

### Styrker og svagheder
**Succesen skyldes:** let at publicere, hypertekst passer til mange informationstyper, og **åbenheden**.

**Problemer:**
- **Dangling links:** flyttes eller slettes en ressource, hænger links (webbet er ikke mobility-transparent)
- **"Lost in hyperspace":** mange links og kilder af tvivlsom pålidelighed. Søgemaskiner og **the semantic web** (RDF) er svar
- **Skala:** populære servere bliver langsomme. Løses med **caching** (browser, proxy) og **clusters** ([[Arkitekturmodeller]])
