/*
-----------========DDL----===========

CREATE...
ALTER ...
DROP  ...  

--DML-------============
INSERT ...  WSTAWIANIE DANYCH
UPDATE ...  POPRAWIA DANE
DELETE ...  USUNIECIE DANYCH


--DCL-----========
COMMIT  - ZATWIERDZENIE
ROLLBACK;

---DATA TYPES---=========
-tekstowe 
CHAR(p) stala dlugosc p
VARCHAR(p) - zmienna dlugosc max p

-numeryczne
NUMBER() - FLOAT
NUMBER(p) - integer -99999, 99999
NUMBER(p,s) - decimal: NUMBER(2,1) 2, 2.5, 3 --p - precyzja, s- scale

-data i czas
DATE  --16354.0

-pola dziwne
CLOB --4GB 
BLOB --filmy, zdjecia
*/

-- tworzenie schematu
----------------------
----------------------

--DROP TABLE studenci CASCADE CONSTRAINTS;
--CREATE TABLE studenci(
--   numerAlbumu    NUMBER(22) --PRIMARY KEY -- in line
--  ,imie           VARCHAR(50 char)  NOT NULL
--  ,nazwisko       VARCHAR(100 char) NOT NULL
--  ,dataUrodzenia  DATE
--  ,skreslony      CHAR(1)           DEFAULT 'N' NOT NULL   --"T"/"N"
--  ,pesel          CHAR(11 char) --UNIQUE
--  ,CONSTRAINT studenci_PK PRIMARY KEY(numerAlbumu) --out of line
--  ,CONSTRAINT studenci_SKR CHECK(skreslony in('T','N'))
--  ,CONSTRAINT studenci_PES UNIQUE(pesel)
--);
--
--DROP TABLE zaliczenia CASCADE CONSTRAINTS;
--CREATE TABLE zaliczenia(
--   symbolPrzedmiotu      VARCHAR(10) NOT NULL
--  ,ocena                 NUMBER(2,1) 
--  ,STUDENCI_numerAlbumu  NUMBER(7) NOT NULL
--  ,CONSTRAINT zaliczenia_ST 
--      FOREIGN KEY (STUDENCI_numerAlbumu) 
--      REFERENCES studenci(numerAlbumu)
--  ,CONSTRAINT zaliczenia_PK PRIMARY KEY (STUDENCI_numerAlbumu,symbolPrzedmiotu)
--);
--  
--   
--    
--SELECT * FROM studenci;
--
--INSERT INTO studenci VALUES(22423,'Adam','Wdowiarek', 
--TO_DATE('5-09-1930','DD-MM-YYYY'),'N',14563289741);
--SELECT * FROM studenci;
--DELETE FROM studenci WHERE numerAlbumu = 22423;
--
--
----INSERT INTO studenci (numerAlbumu,imie,nazwisko, pesel)
----VALUES(123,'Czesiek','Blobek','12345678912');
--
----UPDATE studenci
----SET imie = 'Czeslaw'
----WHERE numerAlbumu = 123;
--
--
--SELECT * FROM studenci;
--SELECT * FROM zaliczenia;
----DESC zaliczenia
----INSERT INTO zaliczenia VALUES('I-BD2-ZP',3.5,22423)



-- TERAZ TU JA EPICKI JESTEM


-- =========================================
-- USUWANIE TABEL (jeœli istniej¹)
-- =========================================
DROP TABLE obecnosci CASCADE CONSTRAINTS;
DROP TABLE lekcje CASCADE CONSTRAINTS;
DROP TABLE studenci CASCADE CONSTRAINTS;
DROP TABLE nauczyciele CASCADE CONSTRAINTS;

-- =========================================
-- TABELA: STUDENCI
-- =========================================
CREATE TABLE studenci (
    numerAlbumu        NUMBER(10),
    imieNazwiskoStudenta VARCHAR2(100 CHAR) NOT NULL,
    grupaDziekanska    VARCHAR2(10 CHAR),
    studentSkreslony   CHAR(1) DEFAULT 'N' NOT NULL,

    CONSTRAINT studenci_PK PRIMARY KEY (numerAlbumu),
    CONSTRAINT studenci_SKR CHECK (studentSkreslony IN ('T','N'))
);

create table twojastara (
    rozmiar number(1000000),
    imie varchar(100 char) NOT NULL,
    
    CONSTRAINT twojastara_PK PRIMARY KEY (imie),
)

-- =========================================
-- TABELA: NAUCZYCIELE
-- =========================================
CREATE TABLE nauczyciele (
    loginNauczyciela       VARCHAR2(10 CHAR),
    imieNazwiskoNauczyciela VARCHAR2(200 CHAR) NOT NULL,
    emailNauczyciela       VARCHAR2(50 CHAR),
    idNauczyciela          VARCHAR2(50 CHAR),

    CONSTRAINT nauczyciele_PK PRIMARY KEY (loginNauczyciela),
    CONSTRAINT nauczyciele_EMAIL_UN UNIQUE (emailNauczyciela)
);

-- =========================================
-- TABELA: LEKCJE
-- =========================================
CREATE TABLE lekcje (
    dzien              DATE,
    godzina            CHAR(8),
    klasa              VARCHAR2(5 CHAR),
    tematZajec         VARCHAR2(500 CHAR),
    nazwaGrupy         VARCHAR2(100 CHAR),
    semestrAkademicki  VARCHAR2(50 CHAR),
    symbolKursu        VARCHAR2(10 CHAR),
    NAUCZYCIELE_loginNauczyciela VARCHAR2(10 CHAR) NOT NULL,

    CONSTRAINT lekcje_PK PRIMARY KEY (dzien, godzina, klasa),

    CONSTRAINT lekcje_TEMAT_UN UNIQUE 
        (tematZajec, nazwaGrupy, semestrAkademicki, symbolKursu),

    CONSTRAINT lekcje_nauczyciele_FK FOREIGN KEY 
        (NAUCZYCIELE_loginNauczyciela)
        REFERENCES nauczyciele(loginNauczyciela)
);

-- =========================================
-- TABELA: OBECNOSCI
-- =========================================
CREATE TABLE obecnosci (
    STUDENCI_numerAlbumu NUMBER(10),
    LEKCJE_dzien         DATE,
    LEKCJE_godzina       CHAR(8),
    LEKCJE_klasa         VARCHAR2(5 CHAR),
    obecnoscRFID         CHAR(1),
    obecnoscNauczyciel   CHAR(1),

    CONSTRAINT obecnosci_PK PRIMARY KEY 
        (STUDENCI_numerAlbumu, LEKCJE_dzien, LEKCJE_godzina, LEKCJE_klasa),

    CONSTRAINT obecnosci_studenci_FK FOREIGN KEY 
        (STUDENCI_numerAlbumu)
        REFERENCES studenci(numerAlbumu),

    CONSTRAINT obecnosci_lekcje_FK FOREIGN KEY 
        (LEKCJE_dzien, LEKCJE_godzina, LEKCJE_klasa)
        REFERENCES lekcje(dzien, godzina, klasa)
);

-- =========================================
-- STUDENCI
-- =========================================
INSERT INTO studenci VALUES (1001, 'Jan Kowalski', 'INF1', 'N');
INSERT INTO studenci VALUES (1002, 'Anna Nowak', 'INF1', 'N');
INSERT INTO studenci VALUES (1003, 'Piotr Zielinski', 'INF2', 'T');

-- =========================================
-- NAUCZYCIELE
-- =========================================
INSERT INTO nauczyciele VALUES ('kowal_j', 'Jan Kowal', 'kowal@szkola.pl', 'N001');
INSERT INTO nauczyciele VALUES ('nowak_a', 'Adam Nowak', 'nowak@szkola.pl', 'N002');

-- =========================================
-- LEKCJE
-- =========================================
INSERT INTO lekcje VALUES (
    DATE '2024-10-01', '08:00', 'A1',
    'Bazy danych - wprowadzenie',
    'INF1', '2024Z', 'BD101',
    'kowal_j'
);

INSERT INTO lekcje VALUES (
    DATE '2024-10-01', '10:00', 'A1',
    'Programowanie',
    'INF1', '2024Z', 'PRG101',
    'nowak_a'
);

-- =========================================
-- OBECNOSCI
-- =========================================
INSERT INTO obecnosci VALUES (1001, DATE '2024-10-01', '08:00', 'A1', 'T', 'T');
INSERT INTO obecnosci VALUES (1002, DATE '2024-10-01', '08:00', 'A1', 'N', 'T');
INSERT INTO obecnosci VALUES (1001, DATE '2024-10-01', '10:00', 'A1', 'T', 'T');

SELECT * FROM studenci;
SELECT * FROM nauczyciele;
SELECT * FROM lekcje;
SELECT * FROM obecnosci;

SELECT 
    s.imieNazwiskoStudenta,
    l.tematZajec,
    l.dzien,
    l.godzina,
    o.obecnoscRFID,
    o.obecnoscNauczyciel
FROM obecnosci o
JOIN studenci s 
    ON o.STUDENCI_numerAlbumu = s.numerAlbumu
JOIN lekcje l 
    ON o.LEKCJE_dzien = l.dzien
   AND o.LEKCJE_godzina = l.godzina
   AND o.LEKCJE_klasa = l.klasa;
   
SELECT 
    l.tematZajec,
    n.imieNazwiskoNauczyciela
FROM lekcje l
JOIN nauczyciele n 
    ON l.NAUCZYCIELE_loginNauczyciela = n.loginNauczyciela;
    
SELECT 
    s.imieNazwiskoStudenta,
    COUNT(*) AS liczba_zajec,
    SUM(CASE WHEN o.obecnoscRFID = 'T' THEN 1 ELSE 0 END) AS obecnosci
FROM obecnosci o
JOIN studenci s 
    ON o.STUDENCI_numerAlbumu = s.numerAlbumu
GROUP BY s.imieNazwiskoStudenta;