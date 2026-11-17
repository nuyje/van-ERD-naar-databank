# Van ERD naar databank

Lesmateriaal voor Applicatie- en databeheer (5e jaar): stap voor stap van een ERD naar een
MySQL-databank met MySQL Workbench (leerplandoel 8, met raakvlakken met leerplandoel 7 en 10).

## Inhoud

| Bestand | Inhoud |
|---|---|
| `index.html` | Startpagina: leerdoelen, benodigdheden, overzicht |
| `1-erd-naar-ontwerp.html` | Omzettingsregels, datatypes, kolomeigenschappen, naamgeving |
| `2-voorbeeld-festival.html` | Uitgewerkt voorbeeld: probleemstelling, ERD, databaseontwerp |
| `3-nieuw-model.html` | Workbench instellen, nieuw model, schema, EER-diagram |
| `4-tabellen.html` | Tabellen en kolommen in de tabeleditor |
| `5-relaties.html` | 1:n, optionele relatie, n:m-koppeltabel |
| `6-forward-engineer.html` | Forward Engineer, het CREATE-script lezen, opnieuw uitvoeren |
| `7-gegevens-invoeren.html` | INSERT INTO-script, volgorde, foutmeldingen |
| `8-integriteit.html` | Referentiële integriteit, RESTRICT / CASCADE / SET NULL |
| `oefeningen.html` | Zes oefeningen, van opwarmer tot eigen ontwerp |
| `spiekbrief.html` | Menu's, sneltoetsen, datatypes, foutcodes |
| `downloads/` | SQL-scripts voor leerlingen (voorbeeld + testscripts oefening 1 en 2) |
| `img/` | Diagrammen (SVG) |
| `css/style.css`, `js/main.js`, `fonts/` | Opmaak, navigatie, lettertypes |

## Publiceren via GitHub Pages

1. Maak een nieuwe repository aan (bv. `databeheer-workbench`).
2. Upload de **inhoud** van deze map (niet de map zelf) naar de hoofdmap van de repository,
   inclusief het verborgen bestand `.nojekyll`.
3. Ga naar **Settings > Pages**. Kies bij *Build and deployment* de bron **Deploy from a branch**,
   branch `main` en map `/ (root)`, en klik op **Save**.
4. Na een minuutje staat de site op `https://<gebruikersnaam>.github.io/<repository>/`.

De site werkt ook lokaal: dubbelklik op `index.html`.

## Zelf aanpassen

- **Tekst**: elke pagina is gewone HTML. Pas de tekst rechtstreeks aan in het bestand.
- **Navigatie** (zijbalk en knoppen vorige/volgende): één lijst `NAV` bovenaan `js/main.js`.
- **Codeblokken**: zet SQL in `<div class="code"><pre><code>...</code></pre></div>`.
  Inkleuren, regelnummers en de kopieerknop komen er automatisch bij.
  Met `data-file="naam.sql"` en `data-download="downloads/naam.sql"` krijgt het blok een titel en een downloadknop.
  Schrijf `&` als `&amp;` en `<` als `&lt;`.
- **Eigen schermafbeeldingen**: de Workbench-schermen op de site zijn vereenvoudigde weergaven.
  Wil je echte screenshots, zet dan een PNG in `img/` en voeg toe:
  `<figure><img src="img/mijn-screenshot.png" alt="beschrijving"><figcaption>uitleg</figcaption></figure>`
- **Controlelijsten**: `<ul class="checklist" data-key="unieke-naam">`. De vinkjes worden enkel in de
  browser van de leerling bewaard (localStorage); er wordt niets doorgestuurd.
- **Voettekst** van de startpagina: onderaan `index.html` (`class="site-foot"`).

## Getest

Alle SQL-scripts (voorbeeld, testscripts en oplossingen) zijn uitgevoerd op MySQL Server 8.0.46.
De stappen in Workbench volgen de handleiding van MySQL Workbench 8.0.

## Licenties

Lettertypes: Atkinson Hyperlegible Next en JetBrains Mono, beide onder de SIL Open Font License
(zie `fonts/`). Alle namen in de voorbeelddatabanken zijn fictief.
