---
tags: [netværk, tcp-ip, osi, lagdeling, encapsulation, eksamen]
kilder: ["Deitel 16.4"]
---

# TCP/IP protocol stack

Del af [[Netværk]]. **Kernestof**: resten af netværksnoterne hænger op her *(Deitel 16.4)*.

> En **protokol** er et sæt regler for, hvordan to entiteter interagerer. En **stack** ordner reglerne i lag, hvor hvert lag kun taler med sin nabo nedad og sin modpart på den anden host.

## Hvorfor lagdeling?
Pointen er **modularisering**, ikke funktionalitet:
- udviklere kan koncentrere sig om **ét lag ad gangen**
- fejlsøgning kan lokaliseres til et lag
- et lag kan **udskiftes** (Ethernet → WiFi) uden at røre lagene over

Samme argument som lagdeling i OS'et og **layering** med middleware i [[Arkitekturmodeller]].

## De fire lag

| Lag | Dataenhed | Ansvar | Rækkevidde |
|---|---|---|---|
| **Application** → [[Application layer]] | besked | Interface mellem applikationer (HTTP, FTP, SMTP, DNS, SSH) | proces → proces, semantisk |
| **Transport** → [[Transport layer]] | segment / datagram | **End-to-end**: pålidelighed, flow, congestion | afsender → endelig modtager |
| **Network** → [[Network layer og IP routing]] | datagram | **Routing**, ét skridt mod destinationen | host → *næste* host |
| **Link** → [[Link layer]] | frame | Bits ↔ fysisk signal, fejldetektion | node → nabonode |

> Netværkslaget på en maskine ved reelt ikke, om destinationen er nabo eller 20 hop væk. Det er transportlaget, der tænker end-to-end.

## Encapsulation

**På vej ned (afsender):** hvert lag tilføjer sin kontrolinformation som **header** (foran) eller **trailer** (bagpå), fx adresser, datatype eller størrelse, og sender videre ned.

**På vej op (modtager):** hvert lag fjerner den header, *det tilsvarende lag* på den anden host satte på, validerer beskeden og sender resten op.

**Hvert lag taler med sin egen modpart** på den anden maskine. Mellemliggende lag læser ikke headeren, de bærer den bare.

```
Afsender                     Modtager
App      [ data ]      →     [ data ]        App
Transport[H|data ]     →     [H|data ]       Transport
Network  [H|H|data ]   →     [H|H|data ]     Network
Link     [H|H|H|data|T] → … → [H|H|H|data|T] Link
              ↓ fysisk medie ↑
```

Tunneling er encapsulation brugt **sidelæns** i stedet for nedad: en pakke lægges ind i en anden pakke på samme lag (se [[Network layer og IP routing#Tunneling]]).

## OSI vs. TCP/IP

**OSI Reference Model** (ISO, 1984) følges ikke strengt på internettet, men terminologien lever videre ("layer 2-switch", "layer 7-firewall").

| OSI (7 lag) | TCP/IP (4 lag) | Hvad OSI's ekstra lag tilføjer |
|---|---|---|
| Application | | Netværksservices til applikationer |
| Presentation | **Application** | Løser **formatinkompatibilitet** (oversætter til fælles format) |
| Session | | **Etablerer, styrer og afslutter** kommunikationen |
| Transport | **Transport** | |
| Network | **Network** | |
| Data link | **Link** | Konverterer datarepræsentation til bits |
| Physical | | Sender bittene over mediet |

> **Eksamensvinkel:** "hvorfor specificerer TCP/IP ikke én protokol pr. lag?" Fordi lagets **interface** er kontrakten, ikke implementationen. Flere protokoller kan udfylde samme lag (TCP **og** UDP), og applikationen vælger den, der passer til dens krav.

## Værd at bide mærke i
- Lagene er en **abstraktion**: alle fire findes typisk i samme OS-kerne
- Ordet **"datagram"** bruges om både UDP-enheder og netværkslagets enheder. Hold styr på laget
- Lagdeling koster: hver header er overhead, hvert lagskifte er behandling. **Performance byttes for håndterbarhed**
- Lagene er ikke et strengt hierarki: RIP kører over UDP, og DNS (applikationslag) er en forudsætning for at bruge IP-adresser
- **The end-to-end argument** ([[Arkitekturmodeller]]): nogle garantier kan **kun** opnås i endepunkterne
- Sikkerhed findes på flere lag: TLS, IPsec og WEP/WPA ([[Sikre protokoller - TLS, IPsec og WiFi]])
