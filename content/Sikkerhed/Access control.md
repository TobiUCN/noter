---
tags: [sikkerhed, access-control, acl, capabilities, rbac, dac, mac, delegation, orange-book, eksamen]
kilder: ["Deitel 19.4, 19.6.6", "Coulouris 11.2.4–11.2.5"]
---

# Access control

Del af [[Sikkerhed]]. Efter [[Autentificering og Kerberos|autentificering]] ("hvem er du?") kommer autorisation: **"hvad må du?"**

> *"The key to operating system security is to control access to internal data and resources"* *(Deitel 19.4)*. Det er OS'ets rolle som resource manager, set fra sikkerhedssiden.

I et distribueret system har en request formen `<op, principal, resource>`. Serveren skal **først autentificere** principalens credentials og **derefter** tjekke rettighederne *(Coulouris 11.2.4)*. Selve beslutningen er ofte applikationsspecifik (Alice må hæve én gang om dagen), men maskineriet er generisk.

## Grundbegreberne

*(Deitel 19.4.1)*

| Begreb | Definition |
|---|---|
| **Subject** | **Aktiv** enhed: bruger, proces, program |
| **Object** | **Passiv** ressource: fysisk (disk, CPU) eller abstrakt (datastruktur, service) |
| **Privilege** | **Måden**, et subject må tilgå et object (read, write, execute …) |
| **Protection domain** | En **samling af access rights** `<objekt, {privileges}>`, fx `<example.txt, {read, write}>` |

Et subject kan også være et object: én proces kan have ret til at tilgå en anden.

Coulouris beskriver protection domain som et **eksekveringsmiljø, som en samling processer deler**, typisk knyttet til én principal. Når en bruger logger ind, oprettes et domæne til brugerens processer (i UNIX bestemt af user- og group-ID). Et protection domain er **kun en abstraktion** med to implementeringer: **ACL'er** og **capabilities**.

### Copy, transfer, propagate

| Operation | A beholder retten? | B kan give den videre? |
|---|---|---|
| **Copy** | Ja | **Nej** |
| **Transfer** | **Nej** | — |
| **Propagate** | Ja | **Ja** |

**Revocation** rejser fire spørgsmål: straks eller forsinket? Alle objekter eller nogle? Ét subject eller hele domænet? Permanent eller midlertidigt? Det er her, ACL'er og capabilities adskiller sig mest.

---

## Model, policy og mekanisme

*(Deitel 19.4.2)*

| Niveau | Definerer | Ændres |
|---|---|---|
| **Security model** | Systemets subjects, objects og privileges | Sjældent |
| **Security policy** | **Hvilke** privileges **hvilke** subjects får | **Ofte** |
| **Security mechanism** | **Hvordan** policyen håndhæves | Sjældent |

> **Hvorfor adskille dem?** Policyen ændrer sig hele tiden; er den adskilt, koster en ændring kun konfiguration, ikke kode. *Separation of policy and mechanism* er et klassisk OS-designprincip.

### Modeller
**User classes** (owner/group/other, som i UNIX): hver fil har én ejer og én gruppe, så **højst én gruppe** kan tilgå en fil, og nye grupperettigheder kræver ændringer på mange filer.

**Role-Based Access Control (RBAC):** brugere tildeles **roller**, og roller tildeles **privileges**. En bruger kan have flere roller, og en hel gruppe ændres ved at ændre én rolle. *Eksempel:* roller student/faculty/staff, objekter assignments/grades.

I distribuerede systemer bliver RBAC til **rollecertifikater**, der knytter principals til roller *(Coulouris 11.2.5)*.

### Policies

| Policy | Hvem bestemmer? | Typisk |
|---|---|---|
| **Principle of least privilege** | Subjectet får **kun** det, opgaven kræver | Grundprincip overalt |
| **Discretionary (DAC)** | **Objektets skaber** | De fleste UNIX-systemer |
| **Mandatory (MAC)** | En **central, foruddefineret** ordning | Højsikkerhed, militær |

> **Hvorfor er MAC sikrere?** Den forhindrer brugere i, ved uheld eller med vilje, at give rettigheder, der kompromitterer systemet. DAC stoler på brugernes dømmekraft; MAC gør ikke.

---

## Mekanismerne

### Access control matrix

*(Deitel 19.4.3)*
Subjects i **rækker**, objects i **kolonner**, rettigheder i cellerne. `*` = kan kopieres videre. Hvad der ikke står, er forbudt.

|  | File A | File B | Printer |
|---|---|---|---|
| Alice | read\*, write\* | read\*, write\* | print\* |
| Bob | read\*, write | read\*, write | print |
| Chris | read | | print |
| David | | read | |

**Problemet:** matrixen er **stor og tynd**, og som ét samlet sted er den et oplagt mål.

### ACL: skær matrixen i kolonner
Gem kun de ikke-tomme celler **pr. object**:
```
File A:  <Alice, {read*, write*}>  <Bob, {read*, write}>  <Chris, {read}>
```
Et domæne i en ACL kan også være et **udtryk** ("ejeren af filen"). Bruges i UNIX og Windows NT *(Coulouris 11.2.4)*.

### Capabilities: skær matrixen i rækker
En **capability** er et **token, der giver privileges til den, der besidder det**, som en billet *(Deitel 19.4.3)*. Protection domain = mængden af capabilities, et subject har.

- Ved oprettelse af et object laves en capability med **fulde rettigheder**
- Kan kopieres; rettigheder kan kun **forblive ens eller indskrænkes**
- Skal være **uforfalskelige**. I et OS: gemt i segmenter, kun OS'et kan tilgå. I et distribueret system: med en **digital signatur** *(Coulouris 11.2.4)*

| Felt (distribueret capability) | Indhold |
|---|---|
| Resource identifier | Unik ID |
| Operations | Tilladte operationer (ofte en bitmap) |
| **Authentication code** | Digital signatur, der gør den uforfalskelig |

| Implementering | Fordel | Ulempe |
|---|---|---|
| **Pointer** til objektet | Hurtig adgang | Alle pointere skal opdateres, hvis objektet flyttes |
| **Token** (bitsekvens) | Uafhængig af placering | Adressen slås op ved første brug (hashing + cache) |

**"Lost object":** forsvinder den sidste capability, kan objektet aldrig tilgås igen. OS'et sikrer, at der altid findes mindst én.

**Ulemperne er de samme som ved fysiske nøgler** *(Coulouris 11.2.4)*: en stjålet capability kan bruges, og en fyret medarbejder "beholder nøglen". Afhjælpning: indlejr indehaverens identitet, timeouts og lister over tilbagekaldte capabilities.

### ACL vs. capabilities

| | **ACL** | **Capabilities** |
|---|---|---|
| Gemt ved | **Object** (kolonne) | **Subject** (række) |
| Nemt spørgsmål | "Hvem må tilgå denne fil?" | "Hvad må denne bruger?" |
| Svært spørgsmål | "Hvad må bruger X?" (gennemsøg alle ACL'er) | "Hvem kan tilgå denne fil?" |
| Adgangstjek | Søg i listen | Bare **præsenter** capability'en |
| **Revocation** | **Let, virker straks** | **Svær**, kopier ligger spredt |
| **Delegation** | Besværlig | **Den pæneste mekanisme** |
| Spredning | Ingen | Svær at kontrollere |

> **Bedst i kombination** *(Coulouris 11.2.4)*: brug ACL ved første adgang og udsted en capability til gentagne adgange. Samme idé som sikre kanaler: autentificér én gang, spar tjekket bagefter.

---

## Credentials og delegation

*(Coulouris 11.2.5)*

**Credentials** = de **beviser**, en principal fremlægger for at få adgang. Simpleste form: et certifikat om identiteten, tjekket mod en ACL.

**"Speaks for":** det er upraktisk at autentificere brugeren ved hver operation, så en credential **taler på vegne af** principalen: en request signeret med brugerens private key antages at komme fra brugeren. Idéen generaliserer:
- **Two-person rule:** følsomme handlinger kræver credentials fra to personer
- **Delegation certificate:** en principal handler på vegne af en anden

Et adgangstjek bliver dermed **evaluering af en logisk formel** over certifikaterne.

**Delegation-problemet:** en printserver skal printe en læsebeskyttet fil, men har ikke rettigheden. Løsning: et **delegation certificate** signeret af brugeren (til netop den fil) eller en **capability** sendt med requesten. **God praksis:** delegér kun en **delmængde** af rettighederne, og **tidsbegræns** dem.

---

## Orange Book (TCSEC, DoD 1985)

*(Deitel 19.6.6)*

Ikke et forsvar, men en **målestok** for OS-sikkerhed. Fire niveauer fra **D (lavest)** til **A (højest)**; hvert niveau indeholder kravene fra niveauet under.

| Niveau | Krav | Eksempler |
|---|---|---|
| **D** | Opfylder intet andet niveau | |
| **C1** | Adskil brugere og data. Login med bruger- **eller gruppenavn**. **DAC** | Tidlige UNIX |
| **C2** | Kun **individuelt** login. Stadig **DAC** | Windows NT, moderne UNIX |
| **B1** | **MAC** + **sensitivity labels** ("Confidential") | HP-UX BLS |
| **B2** | B1 + **sikker kommunikationslinje** ved autentificering | Multics |
| **B3** | B2 + protection domains, **secure recovery**, overvågning af al adgang | XTS-300 |
| **A1** | B3 + **formelt verificeret** | Boeing MLS LAN |

> **Det store spring er C → B: fra DAC til MAC.** Fra B3 til A1 er forskellen ikke flere features, men et **matematisk bevis**.

**Bell–LaPadula** *(Coulouris 11.1)* er en MAC-model, der sikrer, at information på et **højt sikkerhedsniveau ikke flyder ned** i lavere kanaler.
