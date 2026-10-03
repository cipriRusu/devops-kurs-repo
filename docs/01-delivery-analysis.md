# DevOps-analys av Orbital Scada


## 1. Flödet
Systemet finns på plats för 4 års sen, och har fyrtio användare alltid. Det är en små, internsystem utvecklad för en vindkraftgården, utvecklad av en små team, därför incidenthantering kan bli långsamt. De har en devopsflöde på plats som hjälpa de två människor del av det, men om vi ocskå inkludera testning tiden kan bli långre. Det är inte en testare, systemet är testad av användrare.


## 2. Värdeflödeskarta


|Steg|Bearbetningstid|Väntetid|Rätt första gången|
|---|---|---|---|
|utveckling (Development time)|5d|0d|0d(?)|
|testutveckling|1d|0d|0d(?)|
|infrastukturutveckling|0.5d|0d|0d(?)|
|granskning (Review/Examination)|1t(0.24d)|1d|0d(?)|
|release (CI/CD release)|0d|0.5t(0.024d)|0d(?)|
|användrartestning|0d|0d|0d(?)|
|felsökning|0d|2d|0d(?)|
|Summa|6.74d|3.024d|0d(?)|


- Total ledtid: ungefär 9.764 arbetsdagar, alltså nästan en vecka  och halv.
- Andel värdeskapande tid: 6,74 delat med 9.76, alltså ungefär 70 procent.


## 3. De tre största väntetiderna
1. Felsökning: 2d, men det också finns en nuans: med ändrarna i produktion, det är en stor risk några andrär kan ta med tid och de kan hålla in helt systemet. Men det kan ocskå funka bra och väntetider är klippad till någonting.


2. Granskning: 1d, det är en helt normal process. Bara med två utvecklare det är en duktig tid.


3. Release: 0.5t, det är också en helt normal process, och en automatiserad releaseprocess hjälpa helt flöde.


## 4. DORA-måtten för det här flödet


|Mått|Värde|Hur det räknas fram|
|---|---|---|
|Driftsättningsfrekvens|156 per år|3 releaser per vecka|
|Tid från ändring till drift|ungefär 5 dagar|9.764 - 5d om vi dra ut utvecklingstid från helt ledtid - 4.8 dagar|
|Andel misslyckade ändringar|från 156 releaser, 15.6 kan bli fel/använda felsökning, tio percent|ungefär tionde release använda en rollback eller en hotfix|
|Återställningstid|en timme, maximal en dygn|det snabbaste är i veckan men det ta mer i helgen när det arbete inte personalen|


## 5. Bedömning mot kvalitetskriterierna
Korrekthet - Koden har två stora delar: en gammal del, utan unittester och andra säkerhetgranser så denna har koden kan ta mer tid i felsökning. Det nya del är jättesnabbare, men de ocskå använda mer utvecklingstid.


Underhållbarhet - Samma problem, en gammal del som någon nya tar mycket tid att förstå. Om nyckelmänniskör lämna projektet tiden kan växar.


Spårbarhet - En CI-process på plats drivs spårbarhet utan hinder. Men utan tester kan några fel nå användare. Det kan vara fixat med mer tid investerad i mer tester.
Säkerhet - På plats standarder funka jättefint fortfarande: .env, isolerad lösenorden.
 
Tillgänglighet - Det är inga situationer när appen ska bära många användare på samma tid och appen är inte kopplad till public nätverken.


Observerbarhet - N/A


Återställbarhet - N/A


Förutsägbarhet - N/A


OBS: Som utvecklare hade jag inte tillträde på alla mätvärden, så i stället ersattes de med N/A.


## 6. Vad jag skulle ändra först, och varför


Testning fönster: Med en CI/CD process på plats, kommer den största väntetiden från testning. Men en blandning av unittester och användning testning, en stärkare testning process som inkluderar andra typer av tester: E2E tester, integrationstester, inte bara unit tester kan hjälpa med en säkrare process och kan leda till en kortare väntetid.


OBS: Med en utvecklad process redo på plats, en processbrytning avbryta flöden, så bästa vi kan göra är en optimering av redo steg i stället för en komplett åter-implementering som vill avbryta hela processen.




