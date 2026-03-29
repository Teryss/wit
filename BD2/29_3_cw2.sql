DROP TABLE czytelnicy	      CASCADE CONSTRAINTS;
DROP TABLE gatunkiliterackie CASCADE CONSTRAINTS;
DROP TABLE narodowosci	      CASCADE CONSTRAINTS;
DROP TABLE wydawnictwa	      CASCADE CONSTRAINTS;
DROP TABLE autorzy	          CASCADE CONSTRAINTS;
DROP TABLE ksiazki	          CASCADE CONSTRAINTS;
DROP TABLE wypozyczenia	      CASCADE CONSTRAINTS;

CREATE TABLE czytelnicy	         AS SELECT * FROM rafalko.czytelnicy WHERE 1=0;
ALTER  TABLE czytelnicy          ADD CONSTRAINT czytelnicy_PK PRIMARY KEY (numerkarty);
CREATE TABLE gatunkiliterackie   AS SELECT * FROM rafalko.gatunkiliterackie WHERE 1=0;
ALTER  TABLE gatunkiliterackie   ADD CONSTRAINT gatunkiliterackie_PK PRIMARY KEY (id_gatunku);
CREATE TABLE narodowosci	 AS SELECT * FROM rafalko.narodowosci WHERE 1=0;
ALTER  TABLE narodowosci         ADD CONSTRAINT narodowosci_PK PRIMARY KEY (id_narodowosci);
CREATE TABLE wydawnictwa	 AS SELECT * FROM rafalko.wydawnictwa WHERE 1=0;
ALTER  TABLE wydawnictwa         ADD CONSTRAINT wydawnictwa_PK PRIMARY KEY (id_wydawnictwa);
CREATE TABLE autorzy	         AS SELECT * FROM rafalko.autorzy WHERE 1=0;
ALTER  TABLE autorzy             ADD CONSTRAINT autorzy_PK PRIMARY KEY (id_autora);
CREATE TABLE ksiazki	         AS SELECT * FROM rafalko.ksiazki WHERE 1=0;
ALTER  TABLE ksiazki             ADD CONSTRAINT ksiazki_PK PRIMARY KEY (sygnatura);
CREATE TABLE wypozyczenia	 AS SELECT * FROM rafalko.wypozyczenia WHERE 1=0;

INSERT INTO czytelnicy	       SELECT * FROM rafalko.czytelnicy;
INSERT INTO gatunkiliterackie  SELECT * FROM rafalko.gatunkiliterackie;
INSERT INTO narodowosci	       SELECT * FROM rafalko.narodowosci;
INSERT INTO wydawnictwa	       SELECT * FROM rafalko.wydawnictwa;
INSERT INTO autorzy	       SELECT * FROM rafalko.autorzy;
INSERT INTO ksiazki	       SELECT * FROM rafalko.ksiazki;
INSERT INTO wypozyczenia       SELECT * FROM rafalko.wypozyczenia;

COMMIT;

DROP VIEW licznosci;
CREATE VIEW licznosci AS 
    SELECT *
      FROM (      (SELECT  'autorzy' as tabela, COUNT(*) as licznosc FROM autorzy)
            UNION (SELECT 'czytelnicy', COUNT(*) FROM czytelnicy)
            UNION (SELECT 'gatunkiliterackie', COUNT(*) FROM gatunkiliterackie)
            UNION (SELECT 'ksiazki', COUNT(*) FROM ksiazki)
            UNION (SELECT 'narodowosci', COUNT(*) FROM narodowosci)
            UNION (SELECT 'wydawnictwa', COUNT(*) FROM wydawnictwa)
            UNION (SELECT 'wypozyczenia', COUNT(*) FROM wypozyczenia)
           ) 
;
    
SELECT * FROM licznosci;

DESC czytelnicy