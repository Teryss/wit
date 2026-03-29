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
-- USUWANIE TABEL (je�li istniej�)
-- =========================================
--DROP TABLE obecnosci CASCADE CONSTRAINTS;
--DROP TABLE lekcje CASCADE CONSTRAINTS;
--

drop table student cascade constraints;
create table student (
   numeralbumu  integer not null,
   imienazwisko varchar2(100 char) not null,
   grupa        varchar2(10 char),
   czyskreslony char(1),
   constraint student_pk primary key ( numeralbumu ),
   constraint student_skr check ( czyskreslony in ( 'T',
                                                    'N' ) )
);

drop table nauczyciel cascade constraints;
create table nauczyciel (
   login        varchar2(10 char) not null,
   imienazwisko varchar2(200 char) not null,
   email        varchar2(50 char),
   jid          varchar2(50 char),
   constraint nauczyciel_pk primary key ( login ),
   constraint nauczyciel_uq unique ( email )
);

drop table lekcje cascade constraints;
create table lekcje (
   dzien             date not null,
   godzina           char(8) not null,
   klasa             varchar2(5 char) not null,
   temat             varchar2(500 char),
   nazwagrupy        varchar2(100 char),
   semestr           varchar2(50 char),
   symbolkursu       varchar2(10 char),
   nauczyciele_login varchar2(10 char) not null,
   constraint lekcje_pk primary key ( dzien,
                                      godzina,
                                      klasa ),
   constraint lekcje_uq unique ( temat,
                                 nazwagrupy,
                                 semestr,
                                 symbolkursu ),
   constraint lekcje_nauczyciel foreign key ( nauczyciele_login )
      references nauczyciel ( login )
);

drop table obecnosci cascade constraints;
create table obecnosci (
   student_numer      integer,
   lekcje_dzien       date,
   lekcje_godzina     char(8),
   lekcje_klasa       varchar2(5 char),
   obecnoscrfid       char(1),
   obecnoscnauczyciel char(1),
   constraint obecnosci_pk
      primary key ( student_numer,
                    lekcje_dzien,
                    lekcje_godzina,
                    lekcje_klasa ),
   constraint obecnosci_lekcje_fk
      foreign key ( lekcje_dzien,
                    lekcje_godzina,
                    lekcje_klasa )
         references lekcje ( dzien,
                             godzina,
                             klasa ),
   constraint obecnosci_studenci_f foreign key ( student_numer )
      references student ( numeralbumu )
);

insert into nauczyciel values ( 'jd',
                                'Jan Disowski',
                                'jd@jd.com',
                                'jdd' );
select *
  from nauczyciel;

insert into student values ( 123,
                             'Adam Wdowiarek',
                             'INF4',
                             'N' );
insert into student values ( 125,
                             'Jan Kowalski',
                             'INF3',
                             'N' );
select *
  from student;

insert into lekcje values ( to_date('5-09-1930','DD-MM-YYYY'),
                            '18:30',
                            'SALA1',
                            'Tematyka dupa',
                            'INF3',
                            'SEM1',
                            'INF',
                            'jd' );
select *
  from lekcje;

insert into obecnosci values ( 123,
                               to_date('5-09-1930','DD-MM-YYYY'),
                               '18:30',
                               'SALA1',
                               'T',
                               'N'
                               );
select * from OBECNOSCI, STUDENT WHERE OBECNOSCI.STUDENT_NUMER = STUDENT.NUMERALBUMU ;