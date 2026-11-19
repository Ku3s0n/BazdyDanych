use infs_kowalskij;

-- Zadanie 1
CREATE TABLE pracownik (
    id_pracownika INT AUTO_INCREMENT PRIMARY KEY,
    imie VARCHAR(40) NOT NULL,
    nazwisko VARCHAR(60) NOT NULL,
    data_urodzenia DATE NOT NULL
);

INSERT INTO pracownik (imie, nazwisko, data_urodzenia)
VALUES
('Jan', 'Kowalski', '2000-05-12'),
('Adam', 'Nowak', '1999-08-20'),
('Piotr', 'Wisniewski', '2001-03-15');

UPDATE pracownik
SET data_urodzenia = '2000-06-12'
WHERE id_pracownika = 1;

-- Zadanie 2
CREATE TABLE zadanie (
    id_zadania INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_zadania VARCHAR(150) NOT NULL,
    priorytet ENUM('normalny', 'wysoki', 'niski'),
    opis TEXT,
    pracownik INT NULL,

    CONSTRAINT fk_zadanie_pracownik
    FOREIGN KEY (pracownik)
    REFERENCES pracownik(id_pracownika)
    ON DELETE SET NULL
);

ALTER TABLE zadanie
MODIFY priorytet ENUM('normalny', 'wysoki', 'niski')
DEFAULT 'normalny';

INSERT INTO zadanie (nazwa_zadania, priorytet, opis, pracownik)
VALUES
('Przygotowanie dokumentacji', 'wysoki', 'Dokumentacja projektu', 1),
('Analiza danych', 'normalny', 'Analiza zebranych danych', 2),
('Testowanie systemu', 'niski', 'Testy poprawnosci systemu', 3);

-- Zadanie 3
CREATE TABLE projekt (
    id_projektu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_projektu VARCHAR(150),
    data_rozpoczecia DATE,
    data_zakonczenia DATE NULL
);

ALTER TABLE projekt
ADD COLUMN menadzer_projektu INT;

ALTER TABLE projekt
ADD CONSTRAINT fk_projekt_menadzer
FOREIGN KEY (menadzer_projektu)
REFERENCES pracownik(id_pracownika);

INSERT INTO projekt
(nazwa_projektu, data_rozpoczecia, data_zakonczenia, menadzer_projektu)
VALUES
('System informatyczny', '2026-01-01', NULL, 1),
('Strona internetowa', '2026-02-01', NULL, 2);

ALTER TABLE zadanie
ADD COLUMN projekt INT;

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_projekt
FOREIGN KEY (projekt)
REFERENCES projekt(id_projektu)
ON DELETE CASCADE;

UPDATE zadanie
SET projekt = 1
WHERE id_zadania IN (1, 2);

UPDATE zadanie
SET projekt = 2
WHERE id_zadania = 3;

-- Zadanie 4
CREATE TABLE sprint (
    id_sprintu INT AUTO_INCREMENT PRIMARY KEY,
    numer_sprintu INT UNSIGNED,
    data_rozpoczecia DATE,
    data_zakonczenia DATE
);

ALTER TABLE zadanie
ADD COLUMN sprint INT NULL;

ALTER TABLE zadanie
ADD CONSTRAINT fk_zadanie_sprint
FOREIGN KEY (sprint)
REFERENCES sprint(id_sprintu)
ON DELETE SET NULL;

INSERT INTO sprint
(numer_sprintu, data_rozpoczecia, data_zakonczenia)
VALUES
(1, '2026-03-01', '2026-03-14');

UPDATE zadanie
SET sprint = 1
WHERE id_zadania IN (1, 2);

CREATE TABLE status (
    id_statusu INT AUTO_INCREMENT PRIMARY KEY,
    nazwa_statusu VARCHAR(20)
);

-- Zadanie 5
INSERT INTO status (nazwa_statusu)
VALUES
('Nowy'),
('W trakcie'),
('Zakonczony');

CREATE TABLE zadanie_has_status (
    id_zdarzenia INT AUTO_INCREMENT PRIMARY KEY,
    id_zadania INT,
    id_statusu INT,
    data_zdarzenia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_zhs_zadanie
    FOREIGN KEY (id_zadania)
    REFERENCES zadanie(id_zadania)
    ON DELETE CASCADE,

    CONSTRAINT fk_zhs_status
    FOREIGN KEY (id_statusu)
    REFERENCES status(id_statusu)
);

INSERT INTO zadanie_has_status (id_zadania, id_statusu)
VALUES
(1, 1),
(2, 2),
(3, 3);

DELETE FROM projekt
WHERE id_projektu = 1;

SELECT * FROM zadanie;

SELECT * FROM zadanie_has_status;

ALTER TABLE zadanie
DROP FOREIGN KEY fk_zadanie_sprint;

DROP TABLE sprint;


-- Lab_04
-- Zadanie 1
ALTER TABLE zadanie
    DROP FOREIGN KEY fk_zadanie_pracownik;
    
ALTER TABLE projekt
    DROP FOREIGN KEY fk_projekt_menadzer;
    
ALTER TABLE pracownik
    MODIFY id_pracownika INT NOT NULL;

ALTER TABLE pracownik
    DROP PRIMARY KEY;

ALTER TABLE pracownik
    ADD PRIMARY KEY (id_pracownika);

ALTER TABLE pracownik
    MODIFY id_pracownika INT NOT NULL AUTO_INCREMENT;

ALTER TABLE zadanie
    ADD CONSTRAINT fk_zadanie_pracownik
    FOREIGN KEY (pracownik)
    REFERENCES pracownik(id_pracownika)
    ON DELETE SET NULL;

ALTER TABLE projekt
    ADD CONSTRAINT fk_projekt_menadzer
    FOREIGN KEY (menadzer_projektu)
    REFERENCES pracownik(id_pracownika);

-- Zadanie 2

ALTER TABLE zadanie
    ADD COLUMN godziny_szacowane INTEGER DEFAULT 8;

UPDATE zadanie SET godziny_szacowane = 4 WHERE id_zadania = 1;
UPDATE zadanie SET godziny_szacowane = 12 WHERE id_zadania = 2;
UPDATE zadanie SET godziny_szacowane = 16 WHERE id_zadania = 3;

ALTER TABLE zadanie
    ALTER COLUMN godziny_szacowane SET DEFAULT 6;

INSERT INTO zadanie (nazwa_zadania, priorytet, opis, pracownik, projekt)
VALUES ('Optymalizacja zapytan', 'normalny', 'Zadanie testowe', 1, 2);

SELECT id_zadania, nazwa_zadania, godziny_szacowane
FROM zadanie
WHERE nazwa_zadania = 'Optymalizacja zapytan';

DELETE FROM zadanie
WHERE nazwa_zadania = 'Optymalizacja zapytan';

-- Zadanie 3

ALTER TABLE projekt
    ADD COLUMN opis_kratki VARCHAR(50) NULL;

ALTER TABLE projekt
    MODIFY COLUMN opis_kratki VARCHAR(200) NULL;

INSERT INTO projekt (nazwa_projektu, data_rozpoczecia, data_zakonczenia, menadzer_projektu)
VALUES ('Aplikacja mobilna', '2026-03-01', NULL, 3);

UPDATE projekt
SET opis_kratki = 'MVP'
WHERE id_projektu = 2;

UPDATE projekt
SET opis_kratki = 'pilne wdrożenie'
WHERE id_projektu = 3;

ALTER TABLE projekt
    DROP COLUMN opis_kratki;

-- Zadanie 4

ALTER TABLE zadanie
    DROP FOREIGN KEY fk_zadanie_projekt;

ALTER TABLE zadanie
    ADD CONSTRAINT fk_zadanie_projekt
    FOREIGN KEY (projekt)
    REFERENCES projekt(id_projektu)
    ON DELETE SET NULL;

DELETE FROM projekt
WHERE id_projektu = 2;

SELECT id_zadania, nazwa_zadania, projekt
FROM zadanie;


    
    
    