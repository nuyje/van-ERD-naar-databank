-- =====================================================
-- Festival Zomerklanken - testgegevens
-- Alle namen en e-mailadressen zijn fictief.
--
-- Volgorde is belangrijk: eerst de tabellen zonder
-- refererende sleutels ("ouders"), daarna de tabellen
-- die ernaar verwijzen ("kinderen").
-- =====================================================

USE festival;

-- -----------------------------------------------------
-- 1. Ouder-tabellen (geen refererende sleutels)
-- -----------------------------------------------------

INSERT INTO genre (genreID, naam) VALUES
(1, 'Pop'),
(2, 'Rock'),
(3, 'Hiphop'),
(4, 'Dance'),
(5, 'Indie'),
(6, 'Metal');      -- nog geen artiesten in dit genre: dat mag!

INSERT INTO podium (podiumID, naam, capaciteit, overdekt) VALUES
(1, 'Hoofdpodium', 25000, 0),
(2, 'De Schuur', 6000, 1),
(3, 'Club Lantaarn', 2500, 1),
(4, 'Het Bos', 1500, 0);

INSERT INTO campingzone (campingzoneID, naam, maxTenten) VALUES
(1, 'Groen', 800),
(2, 'Rustig', 300),
(3, 'Comfort', 150);

-- -----------------------------------------------------
-- 2. Tabellen die naar de ouders verwijzen
-- -----------------------------------------------------

-- genreID moet bestaan in de tabel genre
INSERT INTO artiest (artiestID, naam, land, genreID) VALUES
(1, 'Neon Atlas', 'België', 4),
(2, 'Sara Volt', 'Nederland', 1),
(3, 'De Kempense Kraaien', 'België', 2),
(4, 'Lil Kwadraat', 'België', 3),
(5, 'Juno & The Waves', 'Verenigd Koninkrijk', 5),
(6, 'Bass Brigade', 'Duitsland', 4),
(7, 'Mira Lune', 'Frankrijk', 1),
(8, 'Rookmelder', 'België', 2),
(9, 'Yasmine K', 'België', 3),
(10, 'Polar Static', 'Noorwegen', 5),
(11, 'Tropicana Tapes', 'Spanje', 4),
(12, 'Kid Kompas', 'Nederland', 3);   -- geannuleerd: geen optredens

-- campingzoneID mag NULL zijn: niet elke bezoeker kampeert
-- Let op D''Hondt: een apostrof in een tekst schrijven we dubbel.
INSERT INTO bezoeker (bezoekerID, voornaam, familienaam, email, geboortedatum, campingzoneID) VALUES
(1, 'Lotte', 'Peeters', 'lotte.peeters@example.com', '2007-03-14', 1),
(2, 'Jonas', 'Janssens', 'jonas.janssens@example.com', '2006-11-02', 1),
(3, 'Emma', 'Maes', 'emma.maes@example.com', '2008-05-21', NULL),
(4, 'Noah', 'Jacobs', 'noah.jacobs@example.com', '2005-08-30', 2),
(5, 'Zoë', 'Hermans', 'zoe.hermans@example.com', '2007-01-09', 1),
(6, 'Arthur', 'Willems', 'arthur.willems@example.com', '2006-06-17', NULL),
(7, 'Nora', 'Claes', 'nora.claes@example.com', '2008-02-28', 3),
(8, 'Mohamed', 'El Amrani', 'mohamed.elamrani@example.com', '2006-09-05', 1),
(9, 'Sofie', 'D''Hondt', 'sofie.dhondt@example.com', '2005-12-12', 2),
(10, 'Finn', 'Vermeulen', 'finn.vermeulen@example.com', '2007-07-23', NULL),
(11, 'Amélie', 'Dubois', 'amelie.dubois@example.com', '2006-04-03', 3),
(12, 'Milan', 'Van den Broeck', 'milan.vandenbroeck@example.com', '2008-10-19', 1),
(13, 'Yara', 'Pauwels', 'yara.pauwels@example.com', '2007-09-27', NULL),
(14, 'Lucas', 'Goossens', 'lucas.goossens@example.com', '2005-01-31', 2),
(15, 'Elena', 'Wouters', 'elena.wouters@example.com', '2006-03-08', 3);

-- -----------------------------------------------------
-- 3. Koppeltabellen (verwijzen naar twee ouders)
-- -----------------------------------------------------

-- Datum: 'JJJJ-MM-DD'   Tijd: 'UU:MM:SS'
INSERT INTO optreden (optredenID, datum, beginuur, einduur, artiestID, podiumID) VALUES
(1, '2027-07-09', '18:00:00', '19:00:00', 8, 4),
(2, '2027-07-09', '19:30:00', '20:30:00', 2, 1),
(3, '2027-07-09', '20:00:00', '21:00:00', 9, 2),
(4, '2027-07-09', '21:30:00', '23:00:00', 1, 1),
(5, '2027-07-09', '22:00:00', '23:30:00', 11, 3),
(6, '2027-07-10', '15:00:00', '16:00:00', 10, 4),
(7, '2027-07-10', '17:00:00', '18:00:00', 5, 2),
(8, '2027-07-10', '18:30:00', '19:30:00', 4, 1),
(9, '2027-07-10', '20:00:00', '21:15:00', 7, 1),
(10, '2027-07-10', '21:00:00', '22:30:00', 6, 3),
(11, '2027-07-10', '22:00:00', '23:30:00', 3, 1),
(12, '2027-07-11', '14:00:00', '15:00:00', 8, 2),
(13, '2027-07-11', '16:00:00', '17:00:00', 9, 1),
(14, '2027-07-11', '17:30:00', '18:30:00', 5, 4),
(15, '2027-07-11', '19:00:00', '20:30:00', 6, 2),
(16, '2027-07-11', '21:00:00', '23:00:00', 1, 1);   -- Neon Atlas speelt 2x op het Hoofdpodium

INSERT INTO favoriet (bezoekerID, artiestID) VALUES
(1, 1), (1, 2), (1, 7),
(2, 4), (2, 9), (2, 12),
(3, 2), (3, 5),
(4, 3), (4, 8), (4, 12),
(5, 1), (5, 6), (5, 11),
(6, 3),
(7, 5), (7, 10),
(8, 4), (8, 9),
(9, 2), (9, 7),
(10, 1), (10, 12),
(11, 7),
(12, 1), (12, 6),
(14, 8),
(15, 2), (15, 5), (15, 10);

-- -----------------------------------------------------
-- 4. Controle: tel het aantal rijen per tabel
-- -----------------------------------------------------
SELECT 'genre' AS tabel, COUNT(*) AS aantal FROM genre
UNION ALL SELECT 'podium', COUNT(*) FROM podium
UNION ALL SELECT 'campingzone', COUNT(*) FROM campingzone
UNION ALL SELECT 'artiest', COUNT(*) FROM artiest
UNION ALL SELECT 'bezoeker', COUNT(*) FROM bezoeker
UNION ALL SELECT 'optreden', COUNT(*) FROM optreden
UNION ALL SELECT 'favoriet', COUNT(*) FROM favoriet;
-- Verwacht: 6 - 4 - 3 - 12 - 15 - 16 - 30
