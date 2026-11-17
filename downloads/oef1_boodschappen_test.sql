-- =====================================================
-- Oefening 1 - Boodschappenlijst: TESTSCRIPT
--
-- Voer dit script uit NADAT je jouw model met Forward
-- Engineer hebt omgezet naar de databank 'boodschappen'.
-- Loopt alles zonder rode kruisjes? Dan klopt je model!
-- Krijg je een fout? Lees de foutmelding: ze vertelt je
-- welke tabel of kolom niet overeenkomt met het ontwerp.
-- =====================================================

USE boodschappen;

INSERT INTO persoon (persoonID, voornaam) VALUES
(1, 'An'),
(2, 'Bart'),
(3, 'Lien'),
(4, 'Wout');

INSERT INTO winkel (winkelID, naam, straatNr, postcode, gemeente) VALUES
(1, 'Supermarkt Centrum', 'Markt 4', '2300', 'Turnhout'),
(2, 'Bakkerij Het Korenaartje', 'Kerkstraat 17', '2275', 'Lille'),
(3, 'Slagerij Van Gorp', 'Dorp 22', '2200', 'Herentals'),
(4, 'Doe-het-zelf Kempen', 'Industrieweg 9', '2440', 'Geel');

INSERT INTO boodschap (boodschapID, omschrijving, hoeveelheid, eenheid, datumIngegeven, persoonID, winkelID) VALUES
(1, 'Halfvolle melk', 6, 'liter', '2026-11-16', 1, 1),
(2, 'Bananen', 1.5, 'kilogram', '2026-11-16', 3, 1),
(3, 'Bruin brood', 1, 'stuk', '2026-11-17', 2, 2),
(4, 'Pistolets', 8, 'stuk', '2026-11-17', 4, 2),
(5, 'Kippenfilet', 0.75, 'kilogram', '2026-11-17', 1, 3),
(6, 'Gehakt half-om-half', 500, 'gram', '2026-11-18', 2, 3),
(7, 'Schroeven 4x40 mm', 2, 'doos', '2026-11-18', 2, 4),
(8, 'Chips paprika', 3, 'zak', '2026-11-18', 4, 1),
(9, 'Spaghetti', 2, 'pak', '2026-11-19', 3, 1),
(10, 'Croissants', 6, 'stuk', '2026-11-20', 4, 2);

-- Enkel als je ook de EXTRA tabel 'openingsuur' gemaakt hebt:
INSERT INTO openingsuur (openingsuurID, dag, opening, sluiting, winkelID) VALUES
(1, 'maandag', '08:30:00', '19:00:00', 1),
(2, 'zaterdag', '08:30:00', '18:00:00', 1),
(3, 'dinsdag', '06:30:00', '13:00:00', 2),
(4, 'zondag', '07:00:00', '12:00:00', 2),
(5, 'vrijdag', '08:00:00', '18:30:00', 3),
(6, 'zaterdag', '09:00:00', '18:00:00', 4);

-- Controle
SELECT 'persoon' AS tabel, COUNT(*) AS aantal FROM persoon
UNION ALL SELECT 'winkel', COUNT(*) FROM winkel
UNION ALL SELECT 'boodschap', COUNT(*) FROM boodschap
UNION ALL SELECT 'openingsuur', COUNT(*) FROM openingsuur;
-- Verwacht: 4 - 4 - 10 - 6
