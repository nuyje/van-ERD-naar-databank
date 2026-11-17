-- =====================================================
-- Oefening 2 - Streamingdienst Kijkbox: TESTSCRIPT
--
-- Voer dit script uit nadat je jouw model met Forward
-- Engineer hebt omgezet naar de databank 'kijkbox'.
-- Het script werkt enkel als je de naamgevingsafspraken
-- gevolgd hebt (tabelnaam = entiteit in kleine letters,
-- PS = <tabel>ID, RS = zelfde naam als de PS).
-- Alle series, titels en profielen zijn fictief.
-- =====================================================

USE kijkbox;

INSERT INTO serie (serieID, titel, beschrijving, startjaar, leeftijdsgrens) VALUES
(1, 'De Kempen Files', 'Twee jonge speurders lossen mysterieuze zaken op in de stille dorpen van de Kempen. Niets is wat het lijkt tussen de dennenbossen.', 2024, 12),
(2, 'Pixelplaneet', 'Vier gamers worden in hun favoriete spel gezogen en moeten samenwerken om level per level te ontsnappen.', 2025, 6),
(3, 'Studio 17', 'Comedy over een groep laatstejaars die stiekem de schoolradio overnemen.', 2026, 9);

INSERT INTO seizoen (seizoenID, nummer, releasejaar, serieID) VALUES
(1, 1, 2024, 1),
(2, 2, 2025, 1),
(3, 1, 2025, 2),
(4, 1, 2026, 3);

INSERT INTO aflevering (afleveringID, nummer, titel, duurMinuten, seizoenID) VALUES
(1, 1, 'De verdwenen fiets', 42, 1),
(2, 2, 'Mist boven het ven', 45, 1),
(3, 3, 'Het geheim van de molen', 44, 1),
(4, 4, 'Ontknoping in Kasterlee', 51, 1),
(5, 1, 'Terug naar af', 46, 2),
(6, 2, 'De stille getuige', 43, 2),
(7, 3, 'Laatste trein naar Turnhout', 55, 2),
(8, 1, 'Game over?', 24, 3),
(9, 2, 'Het lavalevel', 23, 3),
(10, 3, 'Eindbaas', 25, 3),
(11, 4, 'Respawn', 26, 3),
(12, 1, 'Live in de lucht', 28, 4),
(13, 2, 'Storing!', 27, 4),
(14, 3, 'De directeur luistert mee', 30, 4);

INSERT INTO profiel (profielID, gebruikersnaam, email, aangemaaktOp) VALUES
(1, 'gamerjules', 'jules@example.com', '2025-02-14'),
(2, 'lisa_kijkt', 'lisa@example.com', '2025-06-01'),
(3, 'papa_tom', 'tom@example.com', '2024-12-24'),
(4, 'binge_bram', 'bram@example.com', '2026-01-03');

-- Datum + tijd: 'JJJJ-MM-DD UU:MM:SS'
INSERT INTO kijkbeurt (kijkbeurtID, bekekenOp, minutenGekeken, profielID, afleveringID) VALUES
(1, '2026-10-01 20:15:00', 42, 3, 1),
(2, '2026-10-02 20:30:00', 45, 3, 2),
(3, '2026-10-05 16:45:00', 24, 1, 8),
(4, '2026-10-05 17:10:00', 23, 1, 9),
(5, '2026-10-05 17:35:00', 12, 1, 10),
(6, '2026-10-06 19:00:00', 25, 1, 10),   -- Jules kijkt aflevering 10 opnieuw
(7, '2026-10-10 21:00:00', 28, 2, 12),
(8, '2026-10-10 21:30:00', 27, 2, 13),
(9, '2026-10-12 14:00:00', 42, 4, 1),
(10, '2026-10-12 14:45:00', 45, 4, 2),
(11, '2026-10-12 15:30:00', 44, 4, 3),
(12, '2026-10-12 16:20:00', 51, 4, 4);

-- Controle
SELECT 'serie' AS tabel, COUNT(*) AS aantal FROM serie
UNION ALL SELECT 'seizoen', COUNT(*) FROM seizoen
UNION ALL SELECT 'aflevering', COUNT(*) FROM aflevering
UNION ALL SELECT 'profiel', COUNT(*) FROM profiel
UNION ALL SELECT 'kijkbeurt', COUNT(*) FROM kijkbeurt;
-- Verwacht: 3 - 4 - 14 - 4 - 12
