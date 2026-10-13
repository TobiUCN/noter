---
tags: [sikkerhed, firewall, ids, antivirus, patches, efs, open-source, unix, eksamen]
kilder: ["Deitel 19.6, 19.12, 19.13", "Coulouris 11.2.6"]
---

# Forsvarsmekanismer

Del af [[Sikkerhed]]. Svaret på [[Trusler og angreb]].

> Udgangspunktet: **sund fornuft og omhu forhindrer en stor del af angrebene**. Specialiseret hardware og software lægges ovenpå *(Deitel 19.6)*.

| Løsning | Beskytter primært mod |
|---|---|
| Firewall / air gap | Uønsket trafik ind og ud af LAN'et |
| IDS | Indbrud, der er sket eller er i gang |
| Antivirus | Virus og nogle worms |
| Security patches | Kendte sårbarheder |
| Secure file systems | Adgang til data uden om OS'ets access control |

(Orange Book er en **målestok**, ikke et forsvar, og står i [[Access control]].)

---

## Firewalls

Beskytter et **LAN/intranet mod angribere udefra** ved at kontrollere ind- og udgående trafik.

| Grundpolitik | Sikkerhed | Ulempe |
|---|---|---|
| **Forbyd alt, der ikke udtrykkeligt er tilladt** | Høj | Kan blokere legitim trafik |
| **Tillad alt, der ikke udtrykkeligt er forbudt** | Lavere | Mere sårbar, men generer ikke brugerne (typisk hjemmebrugere) |

| | **Packet-filtering firewall** | **Application-level gateway** |
|---|---|---|
| Ser på | Pakkens **afsender/adresse/port** (headeren) | **Indholdet** |
| Eksempel | Afvis indgående pakke med lokal afsenderadresse (spoofet) | Bloker en besked med virus |
| Begrænsning | Ser ikke indholdet | Dyrere |

(*Deitel 19.6.1*.) Packet filtering arbejder på netværks-/transportlaget og gateways på applikationslaget ([[TCP-IP protocol stack]]). Jo højere i stakken, jo mere ved man om trafikkens *betydning*, og jo mere koster det.

### Hvorfor firewalls ikke er nok

*(Coulouris 11.2.6)*

| Begrænsning | Forklaring |
|---|---|
| **Ingen beskyttelse mod interne angreb** | Firewallen ser kun trafikken over grænsen |
| **Grov kontrol** | Alt-eller-intet; man har brug for finkornet deling |
| **Offentlige services** | Kan ikke beskyttes, deres formål er at være åbne |
| **DoS** | En flod af beskeder overvælder ethvert enkelt forsvarspunkt |

**Web tunnel:** betroede eksterne brugere får adgang til interne webservere via en sikker proxy over HTTPS.

> **Det ideelle** er kommunikation mellem gensidigt betroede processer over **sikre kanaler**. Firewalls er et pragmatisk lappeværk, fordi software har fejl *(Coulouris)*.

### Air gap

*(Deitel 19.6.1)*
**Fysisk adskillelse** af internt og eksternt netværk, fx Whale e-Gap: to servere og en memory bank **uden OS**, så der er ingen OS-svagheder at udnytte. Udefrakommende kan ikke se netværkets struktur. Bruges af militær og myndigheder.

## Intrusion Detection Systems

*(Deitel 19.6.2)*
Overvåger netværk og **log-filer** og alarmerer ved mistænkelig adfærd. Kan stoppe processen.

| | **Host-based IDS** | **Network-based IDS** |
|---|---|---|
| Overvåger | System- og applikationslogs | Netværkstrafik |
| God til | **Trojan horses** | **DoS** og uautoriseret adgang |

**Static analysis:** byg en model af applikationens **forventede mønster af system calls**, og alarmer ved afvigelser.

> IDS er aldrig perfekte: **false positives** blokerer legitime brugere, **false negatives** lader angreb passere.

**OCTAVE** (Carnegie Mellon): trusselsvurdering i 3 faser: (1) threat profiles, (2) find sårbarheder, (3) strategi og planer. Det nye er, at **ejerne selv deltager**.

## Antivirus

*(Deitel 19.6.3)*

| Teknik | Hvordan | Styrke | Svaghed |
|---|---|---|---|
| **Signature scanning** | Sammenlign med kendte **virus signatures** | Præcis over for kendte virus | **Variants** og **polymorphic viruses** slipper igennem. Små signaturer (ned til 2 bytes) giver flere fejl |
| **Heuristic scanning** | Genkend **adfærd** (replikation, residens, destruktiv kode) | Fanger nye virus | Falske alarmer |
| **File consistency check** | **Checksums** af beskyttede filer | Alle virus (undtagen worms) må ændre en fil | For dyrt ved meget I/O; hjælper ikke mod virus, der var der før |

*Real-time scanners* ligger i hukommelsen og forebygger aktivt; andre skal startes manuelt.

## Security patches

*(Deitel 19.6.4)*
Udviklerens tre ansvar: (1) find ukendte fejl, (2) udgiv hurtigt patches, (3) **stærke kommunikationskanaler** til brugerne. Det er ikke nok at udgive en patch: **Slammer** udnyttede en fejl, der var patchet 6 måneder før. Derfor automatiske opdateringer.

**OpenBSD:** målet er det mest sikre UNIX-kompatible OS. Kode-audit (hver fil gennemgået flere gange), full disclosure, **secure by default** (minimale services, alle porte lukket), første OS med IPsec. Prisen er begrænset applikationsudvalg og ingen GUI. Mac OS X og Windows Server 2003 fulgte "secure by default".

## Secure file systems

*(Deitel 19.6.5)*
**Problemet:** OS'ets access control virker kun, når **det OS'et** læser disken. Flyttes disken eller bootes et andet OS, **omgås access control fuldstændig**.

**Løsningen:** kryptér selve dataene, fx **EFS** på NTFS (bruger både secret- og public-key; hver bruger har nøglepar + certifikat). Kryptering **pr. mappe** er sikrere end pr. fil, fordi programmer så ikke kan lave temporære filer i plaintext. **Mistes nøglen, er data tabt.**

> **Kryptering i transit ≠ kryptering at rest.** TLS beskytter data under transport, men ikke når de ligger i plaintext hos butikken. Det er det, EFS løser.

---

## Open source vs. proprietær sikkerhed

*(Deitel 19.12)*

| | **Open source** | **Proprietær** |
|---|---|---|
| **For** | **Mange øjne** tester og debugger. Interoperabilitet. Administratorer kan tilpasse | Testet af egne eksperter. Sikre standardindstillinger |
| **Imod** | Distribueres ofte uden sikre standardindstillinger | **"Security through obscurity"**. Virksomheder er tilbageholdende med at indrømme fejl |

> Proprietære systemer *kan* være lige så sikre. Det er ikke modellen, men **disciplinen** (hurtige patches), der afgør det. "Security through obscurity" er præcis det, worst-case-antagelsen "algoritmer er kendt af angriberen" advarer imod ([[Sikkerhed]]).

## UNIX-sikkerhed

*(Deitel 19.13)*

UNIX er designet til at **fremme brugerinteraktion** og er et åbent system, hvilket gør det sværere at sikre. Passwords, salting og shadow-filen står i [[Autentificering og Kerberos]].

| Mekanisme / angreb | Problemet | Forsvar |
|---|---|---|
| **setuid** | Programmet kører med **ejerens** rettigheder. Er ejeren superuser og programmet en shell, bliver alle superuser | Brug sparsomt, gennemgå jævnligt |
| **Falsk login-prompt** | Gemmer det indtastede, melder "forkert password" | Skift password straks, hvis du er i tvivl |
| **`crypt`-kommandoen** | Brugere genbruger nøgler og glemmer plaintext-filer | |
| **For mange superusers** | Fejl fra uerfarne brugere | Begræns superuser. Log al `su`-aktivitet |
| **Falsk `su`** (Trojan horse) | Fanger password og mailer det | Giv aldrig andre skriveadgang til dine mapper |
| **Trap door** | `login` ændres til at acceptere et navn uden password | |
| **"Grab" systemet** | Tusindvis af processer fylder open-file-tabellen = lokal DoS | Grænser pr. proces (kan genere legitime brugere) |

### Forsvar, der kan vendes mod én
- **Låsning efter få fejlede logins** stopper brute force, men en angriber kan bruge det til at **låse administratoren ude**
- **Logs over mislykkede logins** gemmer ofte passwords, fordi brugere taster dem i brugernavnsfeltet

> **Næsten hver sikkerhedsmekanisme har en bagside**, som en angriber kan udnytte. Sikkerhed er ikke en liste af features, men en afvejning.
