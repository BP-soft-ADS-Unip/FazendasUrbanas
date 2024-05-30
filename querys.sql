/* creiando a database no postgre*/
CREATE DATABASE fazendaU;
/* selecionando a database*/
\c fazendau

CREATE TABLE PRODUTOR (
	EMAIL VARCHAR(90) NOT NULL PRIMARY KEY,
	CELULAR VARCHAR(15) NOT NULL,
	NOME VARCHAR(30) NOT NULL,
	SENHA VARCHAR(10) NOT NULL,
	UNIQUE (EMAIL)
);

INSERT INTO PRODUTOR VALUES(
	'mariathereza@uol.com', '459684', 'Maria Thereza', '10mtss');
INSERT INTO PRODUTOR VALUES(
	'joaoc@bol.com', '75752', 'Joao Candido', '8jcss');
INSERT INTO PRODUTOR VALUES(
	'maiara@gamil.com', '88531', 'maiara', '23mccs');
INSERT INTO PRODUTOR VALUES(
	'poly@jis', '881232', 'Polyana', 'poly');
INSERT INTO PRODUTOR VALUES(
	'marcio@lol.com', '225873', 'Marcio', '123456');

        email         | celular |     nome      | senha
----------------------+---------+---------------+--------
 MARCELINO@UNIP.BR    | 456123  | MARCELINO     | MKS&87
 mariathereza@uol.com | 459684  | Maria Thereza | 10mtss
 joaoc@bol.com        | 75752   | Joao Candido  | 8jcss
 maiara@gamil.com     | 88531   | maiara        | 23mccs
 poly@jis             | 881232  | Polyana       | poly
 marcio@lol.com       | 225873  | Marcio        | 123456

 CREATE TABLE PROPRIEDADE (
 	ID SERIAL PRIMARY KEY,
 	TAMANHO INTEGER NOT NULL,
 	RUA VARCHAR(90) NOT NULL,
 	NUMERO INTEGER,
 	BAIRRO VARCHAR(40),
 	CIDADE VARCHAR(40) NOT NULL,
 	ESTADO VARCHAR(2),
 	EMAIL_PROPRIETARIO VARCHAR(90) REFERENCES PRODUTOR (EMAIL)
 	);

 INSERT INTO PROPRIEDADE (TAMANHO, RUA, NUMERO, BAIRRO, CIDADE, ESTADO, EMAIL_PROPRIETARIO)
 VALUES
 (25, 'AURORA', 35, 'VILA TIBERIO', 'RIBEIRAO PRETO', 'SP', 'MARCELINO@UNIP.BR'),
 (15, 'AURORA', 135, 'VILA TIBERIO', 'RIBEIRAO PRETO', 'SP', 'mariathereza@uol.com'),
 (5, 'GOIAS', 935, 'NOVA ALINÇA', 'CAMPINAS', 'SP', 'marcio@lol.com'),
 (3, 'SAUDADE', 12, 'PARAISO', 'PETROPOLIS', 'RJ', 'maiara@gamil.com'),
 (7, 'PEDRO II', 75, 'CENTRO', 'BELO HORIZONTE', 'MG', 'MARCELINO@UNIP.BR'),
 (9, 'MINAS', 789, 'VILA TIBERIO', 'CURITIBA', 'PR', 'poly@jis'),
 (31, 'CAXIAS', 66, 'CENTRO', 'SÃO PAULO', 'SP', 'maiara@gamil.com'),
 (10, 'CARLOS GOMES', 38, 'VILA AUGUSTA', 'SÃO PAULO', 'SP', 'MARCELINO@UNIP.BR'),
 (7, 'SAUDADE', 835, 'CENTRO', 'CAMPO GRANDE', 'MS', 'joaoc@bol.com');

 SELECT P.NOME, PDE.RUA, PDE.BAIRRO, PDE.CIDADE, P.CELULAR, PDE.TAMANHO AS AREA
 FROM PRODUTOR P 
 INNER JOIN PROPRIEDADE PDE 
 ON P.EMAIL = PDE.EMAIL_PROPRIETARIO;

     nome      |     rua      |    bairro    |     cidade     | celular | area
---------------+--------------+--------------+----------------+---------+------
 MARCELINO     | AURORA       | VILA TIBERIO | RIBEIRAO PRETO | 456123  |   25
 Maria Thereza | AURORA       | VILA TIBERIO | RIBEIRAO PRETO | 459684  |   15
 Marcio        | GOIAS        | NOVA ALINÇA  | CAMPINAS       | 225873  |    5
 maiara        | SAUDADE      | PARAISO      | PETROPOLIS     | 88531   |    3
 MARCELINO     | PEDRO II     | CENTRO       | BELO HORIZONTE | 456123  |    7
 Polyana       | MINAS        | VILA TIBERIO | CURITIBA       | 881232  |    9
 maiara        | CAXIAS       | CENTRO       | SÃO PAULO      | 88531   |   31
 MARCELINO     | CARLOS GOMES | VILA AUGUSTA | SÃO PAULO      | 456123  |   10
 Joao Candido  | SAUDADE      | CENTRO       | CAMPO GRANDE   | 75752   |    7

 ALTER TABLE PROPRIEDADE 
 ADD TIPO VARCHAR(20) 
 CHECK (TIPO IN ('HIDROPONIA', 'TRADICIONAL'));

 UPDATE PROPRIEDADE SET TIPO = 'E_NOIS';
 ERRO:  a nova linha da relação "propriedade" viola a restrição de verificação "propriedade_tipo_check"
DETALHE:  Registro que falhou contém (1, 25, AURORA, 35, VILA TIBERIO, RIBEIRAO PRETO, SP, MARCELINO@UNIP.BR, E_NOIS).

UPDATE PROPRIEDADE
SET TIPO = 'HIDROPONIA'
WHERE CIDADE = 'RIBEIRAO PRETO';

UPDATE PROPRIEDADE
SET TIPO = 'TRADICIONAL'
WHERE CIDADE != 'RIBEIRAO PRETO';

 id | tamanho |     rua      | numero |    bairro    |     cidade     | estado |  email_proprietario  |    tipo
----+---------+--------------+--------+--------------+----------------+--------+----------------------+-------------
  1 |      25 | AURORA       |     35 | VILA TIBERIO | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA
  2 |      15 | AURORA       |    135 | VILA TIBERIO | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA  | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL
  4 |       3 | SAUDADE      |     12 | PARAISO      | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL
  5 |       7 | PEDRO II     |     75 | CENTRO       | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL
  6 |       9 | MINAS        |    789 | VILA TIBERIO | CURITIBA       | PR     | poly@jis             | TRADICIONAL
  7 |      31 | CAXIAS       |     66 | CENTRO       | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL
  9 |       7 | SAUDADE      |    835 | CENTRO       | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL

 INSERT INTO PROPRIEDADE(RUA, BAIRRO, CIDADE, ESTADO, TIPO, EMAIL_PROPRIETARIO, NUMERO, TAMANHO) 
 VALUES ('7', 'CENTRO', 'Jau', 'SP', 'HIDROPONIA', 'marcio@lol.com', 568, 7);

 SELECT * FROM PRODUTOR WHERE EMAIL = 'marcelino@unip.br';



// trabalho em 26/05/2024  - Domingo



 ALTER TABLE produtor ADD
 chave_pix VARCHAR (255);

 TABLE "propriedade" CONSTRAINT "propriedade_email_proprietario_fkey" FOREIGN KEY (email_proprietario) REFERENCES produtor(email)

 
CREATE TABLE prodAgricola (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL
	);

INSERT INTO prodAgricola(nome)
VALUES 
('ALFACE'),
('COUVE'),
('AGRIAO'),
('TOMATE'),
('QUIABO');

SELECT * FROM prodAgricola;

 id |  nome
----+--------
  1 | ALFACE
  2 | COUVE
  3 | AGRIAO
  4 | TOMATE
  5 | QUIABO
(5 linhas)

// tabela plantio

CREATE TABLE plantio (
	ID SERIAL PRIMARY KEY,
	data_plantio TIMESTAMP NOT NULL,
	area INTEGER NOT NULL,
	id_propriedade INTEGER REFERENCES PROPRIEDADE (id),
	id_prodAgricola INTEGER REFERENCES prodAgricola (id)
	);

// Há um problema sobre a área de plantio (deve ser menor que o tamanho da propriedade)
//e menor que o total da área plantada
//resoluçõa; criar um campo área plantada na tabela propriedade e fazer um trigger para atualizar toda vez que iserir plantio
// fazer um check na área do plantio para ser menor ou igual a área plantada da tabela propriedade)

//RESOLUÇÕES:
// criar campo area_plantada na tabela propredade
/*ALTER TABLE propriedade DROP COLUMN area_plantada;

SELECT * FROM propriedade;*/

//fazer o check área plantio deve ser menor que a diferença do tamnaho e ára area_plantada
ALTER TABLE propriedade ADD
area_plantada INTEGER 
CHECK (area_plantada <= tamanho);

\d propriedade;
                                          Tabela "public.propriedade"
       Coluna       |         Tipo          | OrdenaþÒo | Pode ser nulo |                 PadrÒo
--------------------+-----------------------+-----------+---------------+-----------------------------------------
 id                 | integer               |           | not null      | nextval('propriedade_id_seq'::regclass)
 tamanho            | integer               |           | not null      |
 rua                | character varying(90) |           | not null      |
 numero             | integer               |           |               |
 bairro             | character varying(40) |           |               |
 cidade             | character varying(40) |           | not null      |
 estado             | character varying(2)  |           |               |
 email_proprietario | character varying(90) |           |               |
 tipo               | character varying(20) |           |               |
 area_plantada      | integer               |           |               |
═ndices:
    "propriedade_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "propriedade_check" CHECK (area_plantada <= tamanho)
    "propriedade_tipo_check" CHECK (tipo::text = ANY (ARRAY['HIDROPONIA'::character varying, 'TRADICIONAL'::character varying]::text[]))
Restriþ§es de chave estrangeira:
    "propriedade_email_proprietario_fkey" FOREIGN KEY (email_proprietario) REFERENCES produtor(email)
Referenciada por:
    TABLE "plantio" CONSTRAINT "plantio_id_propriedade_fkey" FOREIGN KEY (id_propriedade) REFERENCES propriedade(id)



//teste
UPDATE propriedade SET area_plantada = 30 WHERE id = 1;
ERRO:  a nova linha da relação "propriedade" viola a restrição de verificação "propriedade_check"
DETALHE:  Registro que falhou contém (1, 25, AURORA, 35, VILA TIBERIO, RIBEIRAO PRETO, SP, MARCELINO@UNIP.BR, HIDROPONIA, 30).
// teste OK.

 id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |
(12 linhas)




//fazer a trigger de atualização para inserir valor na area_plantada ta tabela propriedade toda vez que somar valor no campo area da tabela plantio 
CRETE TRIGGER atualizar_area_plantada
[before/after] [update] on tabela propriedade
	for each [row/statement] execute procedure soma_area();


// trabalho em 27/05/2024
/*DELETE FROM plantio;
SELECT * FROM plantio;

//
WHERE NEW.plantio.id_propriedade = OLD.id;
WHERE id = NEW.plantio.id_propriedade;
WHERE NEW.id_propriedade FROM plantio = OLD.id;

faltando entrada para tabela "plantio" na cláusula FROM
LINHA 3: WHERE id = NEW.plantio.id_propriedade
                    ^
CONSULTA:  UPDATE propriedade
SET area_plantada = NEW.plantio.area + OLD.area_plantada
WHERE id = NEW.plantio.id_propriedade
CONTEXTO:  função PL/pgSQL somar_area() linha 3 em comando SQL
fazendau=!#
fazendau=!# SELECT * FROM plantio;
ERRO:  transação atual foi interrompida, comandos ignorados até o fim do bloco de transação
*/






BEGIN;

CREATE OR REPLACE FUNCTION somar_area()
RETURNS trigger AS
$$
	BEGIN
		UPDATE propriedade
		SET area_plantada = area_plantada + NEW.area
		WHERE id = NEW.id_propriedade;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER atualizar_area_plantada
AFTER INSERT ON plantio 
	FOR EACH ROW
	EXECUTE FUNCTION somar_area(); 


INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 2, 3, 1),
(CURRENT_TIMESTAMP, 10, 1, 2);

SELECT * FROM plantio;
 id |        data_plantio        | area | id_propriedade | id_prodagricola
----+----------------------------+------+----------------+-----------------
 15 | 2024-01-01 08:00:00        |    2 |              3 |               1
 16 | 2024-05-27 14:54:00.611617 |   10 |              1 |               2
 23 | 2024-01-01 08:00:00        |    2 |              3 |               1
 24 | 2024-05-27 15:41:42.860301 |   10 |              1 |               2
SELECT * FROM propriedade;
 id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |             0
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             2
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10
//ROLLBACK;
COMMIT;

//trabalho em 28/05/2024
// verificando a estrutura de data_plantio
\d plantio;
                                             Tabela "public.plantio"
     Coluna      |            Tipo             | OrdenaþÒo | Pode ser nulo |               PadrÒo
-----------------+-----------------------------+-----------+---------------+-------------------------------------
 id              | integer                     |           | not null      | nextval('plantio_id_seq'::regclass)
 data_plantio    | timestamp without time zone |           | not null      |
 area            | integer                     |           | not null      |
 id_propriedade  | integer                     |           |               |
 id_prodagricola | integer                     |           |               |
═ndices:
    "plantio_pkey" PRIMARY KEY, btree (id)
Restriþ§es de chave estrangeira:
    "plantio_id_prodagricola_fkey" FOREIGN KEY (id_prodagricola) REFERENCES prodagricola(id)
    "plantio_id_propriedade_fkey" FOREIGN KEY (id_propriedade) REFERENCES propriedade(id)
Gatilhos:
    atualizar_area_plantada AFTER INSERT ON plantio FOR EACH ROW EXECUTE FUNCTION somar_area()
 --------------------------------------------------

DELETE FROM plantio;
SELECT * FROM plantio;
 id | data_plantio | area | id_propriedade | id_prodagricola
----+--------------+------+----------------+-----------------
(0 linha)

BEGIN;
ALTER TABLE plantio DROP COLUMN area;
SELECT * FROM plantio;
 id | data_plantio | id_propriedade | id_prodagricola
----+--------------+----------------+-----------------
(0 linha)
COMMIT;

// INCLUIR UM CHECK NA TABELA plantio

BEGIN;

ALTER TABLE plantio
ADD area INTEGER;

\d plantio;

//não consegui TENTAR ARRUMAR NA FUNÇÃO

BEGIN;

CREATE OR REPLACE FUNCTION somar_area()
RETURNS trigger AS
$$
	BEGIN
		IF (NEW.area > (SELECT (tamanho - area_plantada) FROM propriedade WHERE id = NEW.id_propriedade)) THEN
			DELETE FROM plantio WHERE id = NEW.id_propriedade;
			RAISE EXCEPTION 'Area a ser inserida maior que a disponivel para plantio';
			
		END IF;
		UPDATE propriedade
		SET area_plantada = area_plantada + NEW.area
		WHERE id = NEW.id_propriedade;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

(SELECT (tamanho - area_plantada) FROM propriedade WHERE id = NEW.id_propriedade)
//TESTES ANTES DELETAR CAMPOS DE ÁREA PLANTADA EM id_propriedade

BEGIN;
UPDATE propriedade SET area_plantada = 0;
SELECT * FROM propriedade;
 id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |             0
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             0
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0

SELECT * FROM plantio;

BEGIN;
INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 2, 3, 1),
(CURRENT_TIMESTAMP, 10, 1, 2);

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 27 | 2024-01-01 08:00:00        |              3 |               1 |    2
 28 | 2024-05-28 10:12:33.825601 |              1 |               2 |   10
(2 linhas)

SELECT * FROM propriedade;
id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |             0
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             2
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10

COMMIT;

// MAIS TESTES - VERIFICANDO A SOMA DA area_plantada

BEGIN;
INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 3, 3, 3),
(CURRENT_TIMESTAMP, 10, 2, 2);

SELECT * FROM plantio;

SELECT * FROM propriedade;
 id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |             0
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             5
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10

  // VERIFICANDO SE ACIONA O Gatilhos


INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 3, 3, 3),
(CURRENT_TIMESTAMP, 10, 2, 2);

SELECT * FROM plantio;

SELECT * FROM propriedade; 

ERRO:  Area a ser inserida maior que a disponivel para plantio
CONTEXTO:  função PL/pgSQL somar_area() linha 5 em RAISE
fazendau=#
fazendau=# SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 27 | 2024-01-01 08:00:00        |              3 |               1 |    2
 28 | 2024-05-28 10:12:33.825601 |              1 |               2 |   10
 29 | 2024-01-01 08:00:00        |              3 |               3 |    3
 30 | 2024-05-28 10:18:15.060152 |              2 |               2 |   10
(4 linhas)


fazendau=#
fazendau=# SELECT * FROM propriedade;
 id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |             0
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |             0
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             5
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10

// tudo ok!!!!!!



 SELECT PL.id, PROP.tamanho, PROP.tipo, PROP.area_plantada, AGR.nome AS prod_agricola, PL.area, PL.data_plantio
	 FROM plantio PL
	 INNER JOIN propriedade PROP 
	 ON (PROP.id = PL.id_propriedade)
	 INNER JOIN prodAgricola AGR
	 ON (AGR.id = PL.id_prodAgricola);

 id | tamanho |    tipo     | area_plantada | prod_agricola | area |        data_plantio
----+---------+-------------+---------------+---------------+------+----------------------------
 27 |       5 | TRADICIONAL |             5 | ALFACE        |    2 | 2024-01-01 08:00:00
 28 |      25 | HIDROPONIA  |            10 | COUVE         |   10 | 2024-05-28 10:12:33.825601
 29 |       5 | TRADICIONAL |             5 | AGRIAO        |    3 | 2024-01-01 08:00:00
 30 |      15 | HIDROPONIA  |            10 | COUVE         |   10 | 2024-05-28 10:18:15.060152
// criação do view

BEGIN;

CREATE VIEW info_plantio AS 
	SELECT PL.id, PROP.tamanho, PROP.tipo, PROP.area_plantada, AGR.nome AS prod_agricola, PL.area AS AREA_M2, PL.data_plantio
		 FROM plantio PL
		 INNER JOIN propriedade PROP 
		 ON (PROP.id = PL.id_propriedade)
		 INNER JOIN prodAgricola AGR
		 ON (AGR.id = PL.id_prodAgricola);

COMMIT;

SELECT * FROM info_plantio;

id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 27 |       5 | TRADICIONAL |             5 | ALFACE        |       2 | 2024-01-01 08:00:00
 28 |      25 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-05-28 10:12:33.825601
 29 |       5 | TRADICIONAL |             5 | AGRIAO        |       3 | 2024-01-01 08:00:00
 30 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-05-28 10:18:15.060152

// VIEW OK (info_plantio)

// criação da tabela colheita_estoque
 id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 27 | 2024-01-01 08:00:00        |              3 |               1 |    2
 28 | 2024-05-28 10:12:33.825601 |              1 |               2 |   10
 29 | 2024-01-01 08:00:00        |              3 |               3 |    3
 30 | 2024-05-28 10:18:15.060152 |              2 |               2 |   10
(4 linhas)

BEGIN;

CREATE TABLE colheita_estoque (
	id_colheita SERIAL PRIMARY KEY,
	data_colheita TIMESTAMP NOT NULL,
	quantidade INTEGER NOT NULL,
	preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario > 0),
	id_plantio INTEGER REFERENCES plantio (id)
	
	);
                                                Tabela "public.colheita_estoque"
     Coluna     |            Tipo             | OrdenaþÒo | Pode ser nulo |                        PadrÒo
----------------+-----------------------------+-----------+---------------+-------------------------------------------------------
 id_colheita    | integer                     |           | not null      | nextval('colheita_estoque_id_colheita_seq'::regclass)
 data_colheita  | timestamp without time zone |           | not null      |
 quantidade     | integer                     |           | not null      |
 preco_unitario | numeric(10,2)               |           | not null      |
 id_plantio     | integer                     |           |               |
═ndices:
    "colheita_estoque_pkey" PRIMARY KEY, btree (id_colheita)
Restriþ§es de verificaþÒo:
    "colheita_estoque_preco_unitario_check" CHECK (preco_unitario > 0::numeric)
Restriþ§es de chave estrangeira:
    "colheita_estoque_id_plantio_fkey" FOREIGN KEY (id_plantio) REFERENCES plantio(id)


fazendau=*# commit;
COMMIT  // ok!!!!!

// criação funçã e trigger para descontar na area_plantada da tabela propriedade

BEGIN;

CREATE OR REPLACE FUNCTION descontar_area()
RETURNS trigger AS
$$
	BEGIN
		
		UPDATE propriedade PR
		SET area_plantada = area_plantada - (

			SELECT area
			FROM plantio 
			WHERE plantio.id = NEW.id_plantio)
		FROM plantio, colheita_estoque
		WHERE PR.id = plantio.id_propriedade AND plantio.id = NEW.id_plantio;
		

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

commit;

/* id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |             0
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |             0
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |             0
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |             0
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |             0

   id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 27 | 2024-01-01 08:00:00        |              3 |               1 |    2
 28 | 2024-05-28 10:12:33.825601 |              1 |               2 |   10
 29 | 2024-01-01 08:00:00        |              3 |               3 |    3
 30 | 2024-05-28 10:18:15.060152 |              2 |               2 |   10

ERRO:  faltando entrada para tabela "plantio" na cláusula FROM*/

/*UPDATE propriedade
		SET area_plantada = area_plantada + NEW.area
		WHERE id = NEW.id_propriedade;

		RETURN NEW;*/


CREATE TRIGGER descontar_area_plantada
AFTER INSERT ON colheita_estoque 
	FOR EACH ROW
	EXECUTE FUNCTION descontar_area(); 

COMMIT;


// TESTAR AS TABELAS

BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 70, 5.10, 27);

/*SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
           7 | 2024-05-29 10:23:10.776238 |         70 |           5.10 |         27
(1 linha)

SELECT * FROM info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 27 |       5 | TRADICIONAL |             3 | ALFACE        |       2 | 2024-01-01 08:00:00
 28 |      25 | HIDROPONIA  |             8 | COUVE         |      10 | 2024-05-28 10:12:33.825601
 29 |       5 | TRADICIONAL |             3 | AGRIAO        |       3 | 2024-01-01 08:00:00
 30 |      15 | HIDROPONIA  |             8 | COUVE         |      10 | 2024-05-28 10:18:15.060152

 UPDATE propriedade SET area_plantada = 10
 WHERE id = 1 OR id = 2;*/
// não funcionou pois descontou em todos os registros de area_plantada

BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 250, 7, 28);

SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
           7 | 2024-05-29 10:23:10.776238 |         70 |           5.10 |         27
          12 | 2024-05-29 11:16:13.525705 |        250 |           7.00 |         28

SELECT * FROM info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 27 |       5 | TRADICIONAL |             3 | ALFACE        |       2 | 2024-01-01 08:00:00
 28 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-05-28 10:12:33.825601
 29 |       5 | TRADICIONAL |             3 | AGRIAO        |       3 | 2024-01-01 08:00:00
 30 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-05-28 10:18:15.060152

 COMMIT;

 //incluir um view de info_colheita


BEGIN;
CREATE VIEW info_colheita AS
	SELECT CE.id_colheita, PL.data_plantio, CE.data_colheita, AGR.nome AS prod_agricola, PL.area AS area_m2,
	 CE.quantidade, (CE.quantidade/PL.area) AS rendimento, CE.preco_unitario
		FROM colheita_estoque CE 
		INNER JOIN plantio PL
		ON (PL.id = CE.id_plantio)
		INNER JOIN prodAgricola AGR
		ON (AGR.id = PL.id_prodagricola);


SELECT * FROM info_colheita;

COMMIT;
