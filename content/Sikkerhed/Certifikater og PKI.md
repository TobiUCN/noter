---
tags: [sikkerhed, certifikater, pki, x509, spki, pgp, ca, eksamen]
kilder: ["Deitel 19.2.2, 19.9", "Coulouris 11.2.3, 11.4.4"]
---

# Certifikater og PKI

Del af [[Sikkerhed]]. Public-key-kryptografi ([[Kryptografi]]) siger intet om, **hvem en public key tilhører**. Hvordan ved kunden, at sitet ikke er en tredjepart, der udgiver sig for butikken? Det løser certifikater.

## Hvad et certifikat er

**Et digitalt certifikat** = et kort udsagn, **signeret af en principal** *(Coulouris 11.2.3)*. Typisk udsagnet "denne public key tilhører dette subject", men det kan være alt, fx "Alice er medlem af Friendly Society".

**PKI** = public-key-kryptografi + digitale certifikater + **certificate authorities (CA)** *(Deitel 19.9)*.

### Eksemplet: Bob's Bank

*(Coulouris 11.2, scenarie 5)*
Alice har et certifikat fra Bob's Bank om sit kontonummer og bruger det ved køb hos Carol. **Men** Carol skal kende Bobs **ægte** public key, ellers kunne Alice lave sit eget nøglepar og forfalske et certifikat "fra Bob's Bank". Løsningen er et **public-key-certifikat for Bob**, signeret af Fred (Bankers Federation):

| Felt | Værdi |
|---|---|
| Certificate type | Public key |
| Name | Bob's Bank |
| Public key | `KBpub` |
| Certifying authority | Fred – The Bankers Federation |
| Signature | `{Digest(field 2 + field 3)}KFpriv` |

### Det rekursive problem
Freds certifikat er kun så godt som **Freds public key**. Rekursionen brydes, når Carol får `KFpub` på en måde, Carol **stoler på** (personligt eller via en, Carol kender). Det er en **certification chain**.

| Problem | Hvorfor |
|---|---|
| **Hvem er startpunktet for tillid?** | Tillid er sjældent absolut og afhænger af formålet |
| **Kompromitterede private keys** | Så kan alt signeret med dem forfalskes |
| **Kædens længde** | **Jo længere kæde, jo større risiko for et svagt led** |

**Hvorfor certifikater alligevel er vigtige:** de løser **skalaproblemet**. Identitet for milliarder af mennesker etableres gennem kæder af betroede udsagn. For at være nyttige kræves et **standardformat** (X.509) og **enighed om, hvordan kæder bygges**.

---

## X.509 og CA-hierarkiet

**X.509** er det mest udbredte format og del af X.500-directory-standarden ([[Directory services, X.500 og GNS]]) *(Coulouris 11.4.4)*.

| Felt | Indhold |
|---|---|
| **Subject** | Distinguished Name, **public key** |
| **Issuer** | Distinguished Name, **signatur** |
| **Period of validity** | Not Before, Not After |
| **Administrative information** | Version, **serienummer** |
| **Extended information** | |

Bindingen mellem nøgle og subject ligger i **udstederens signatur** (CA'en krypterer subjectets public key eller dens hash med sin egen private key). Certifikater lægges i offentlige **certificate repositories** *(Deitel 19.9)*. Verifikation er to-trins: hent CA'ens certifikat fra en **pålidelig kilde**, og validér signaturen.

**Distinguished Name** skulle være globalt unikt via X.500, men da der ikke findes en global X.500, er det i praksis en beskrivende streng.

### CA-træet

*(Deitel 19.9)*
```
IPRA (Internet Policy Registration Authority), roden, signerer med root key
 └── Policy creation authorities: sætter regler for udstedelse
      └── CA'er
           └── Personer og organisationer
```
Hver node stoler på sin forælder; til sidst skal man stole på **roden**. Browsere leveres med indbyggede CA-nøgler, så det første led kommer ad en anden kanal (se [[Sikre protokoller - TLS, IPsec og WiFi#Man-in-the-middle i TLS|TLS]]).

> **CA'en er det svage punkt:** VeriSign udstedte engang to certifikater til en bedrager, der udgav sig for at være fra Microsoft, så ondsindet kode kunne fremstå "signeret af Microsoft".

## Web of trust og SPKI

**PGP** bygger på et **web of trust**: brugere **signerer hinandens public keys**, når de har verificeret identiteten personligt. Der er ingen central autoritet, og tilliden vokser med antallet af brugere, så det egner sig til grupper *(Deitel 19.2.2)*.

**SPKI** formaliserer samme tankegang *(Coulouris 11.4.4)*. Kritikken af X.509 er, at **global unikhed af navne er urealistisk**: i praksis gøres en person unik **gennem relationer** (kørekort, brev fra banken). SPKI behandler kæder af certifikater med logisk inferens:
> "Bob tror, Alices public key er KApub" + "Carol stoler på Bob angående Alices nøgler" ⇒ "Carol tror, Alices public key er KApub"

| | **X.509 / CA-træ** | **SPKI / web of trust** |
|---|---|---|
| Identitet | **Globalt unikt** navn | Unik **i forhold til** andre |
| Tillid | **Hierarki** med en rod | **Kæder** gennem betroede principals |
| Kædelængde | Kort | Længere (kan caches) |
| Overbevisningskraft | Afhænger af CA'en | Ofte mere overbevisende |

## Tilbagekaldelse (revocation)

At finde og slette alle kopier af et certifikat er urealistisk *(Coulouris 11.2.3)*.

| Mekanisme | Hvordan | Ulempe |
|---|---|---|
| **Udløbsdato** | Modtagere afviser udløbne certifikater; subjectet må forny | Langsom, hvis en nøgle lækker i dag |
| **CRL** (Certificate Revocation List) | CA'en vedligeholder liste over tilbagekaldte certifikater | Validering kan tage lang tid |
| **OCSP** | Validering **i realtid** | Kræver online-opslag |

(CRL og OCSP: *Deitel 19.9*.) Udløb er worst-case-reglen "begræns levetiden af hemmeligheder" igen.

**Certifikater vs. capabilities:** et certifikat om Alices bankkonto adskiller sig fra en capability kun ved, at det mangler operationslisten og navngiver udstederen *(Coulouris 11.2.4)*, se [[Access control]].

### Er e-handel sikker?

*(Deitel 19.9)*
PKI-transaktioner er **sikrere** end at give kortnummeret over telefonen, fordi algoritmerne er praktisk umulige at bryde, mens en telefonlinje kan aflyttes. **Men** stigende regnekraft kan gøre nutidens algoritmer svage i fremtiden.
