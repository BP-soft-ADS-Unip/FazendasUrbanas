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



// trabalho em 30/05/2024  - criação de mais 3 tabelas (cliente, pedido_venda, item_pedido)

// criação tabela cliente

BEGIN;
CREATE TABLE cliente (
	email VARCHAR(90) NOT NULL PRIMARY KEY,
	celular VARCHAR(15) NOT NULL,
	nome VARCHAR(90) NOT NULL,
	senha VARCHAR(10) NOT NULL,
	UNIQUE (email)
);
\d cliente;
                       Tabela "public.cliente"
 Coluna  |         Tipo          | OrdenaþÒo | Pode ser nulo | PadrÒo
---------+-----------------------+-----------+---------------+--------
 email   | character varying(90) |           | not null      |
 celular | character varying(15) |           | not null      |
 nome    | character varying(90) |           | not null      |
 senha   | character varying(10) |           | not null      |
═ndices:
    "cliente_pkey" PRIMARY KEY, btree (email)

COMMIT;


BEGIN;
INSERT INTO cliente VALUES (
	'filinha@papai.com', '458278', 'Ana Castela', 'ana1');

INSERT INTO cliente VALUES (
	'meninao@uol.com', '450278', 'Carlos Augusto', 'carlos1');

INSERT INTO cliente VALUES (
	'cesarfilho@sbt.com', '1458278', 'Cesar Filho Augusto', 'cesar1');

SELECT * FROM cliente;
       email        | celular |        nome         |  senha
--------------------+---------+---------------------+---------
 filinha@papai.com  | 458278  | Ana Castela         | ana1
 meninao@uol.com    | 450278  | Carlos Augusto      | carlos1
 cesarfilho@sbt.com | 1458278 | Cesar Filho Augusto | cesar1

// sucesso!!!!


// criação da tabela pedido_venda


BEGIN;
CREATE TABLE pedido_venda (
	id SERIAL PRIMARY KEY,
	data TIMESTAMP NOT NULL,
	valor NUMERIC(12,2) CHECK (valor >= 0),
	email_cliente VARCHAR(90) REFERENCES cliente (email)

);
\d pedido_venda;

                                            Tabela "public.pedido_venda"
    Coluna     |            Tipo             | OrdenaþÒo | Pode ser nulo |                  PadrÒo
---------------+-----------------------------+-----------+---------------+------------------------------------------
 id            | integer                     |           | not null      | nextval('pedido_venda_id_seq'::regclass)
 data          | timestamp without time zone |           | not null      |
 valor         | numeric(12,2)               |           |               |
 email_cliente | character varying(90)       |           |               |
═ndices:
    "pedido_venda_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "pedido_venda_valor_check" CHECK (valor >= 0::numeric)
Restriþ§es de chave estrangeira:
    "pedido_venda_email_cliente_fkey" FOREIGN KEY (email_cliente) REFERENCES cliente(email)

 COMMIT;



// criação da tabela item_pedido
BEGIN;
CREATE TABLE item_pedido (
	id SERIAL PRIMARY KEY,
	quantidade INTEGER NOT NULL CHECK (quantidade >= 0),
	id_estoque INTEGER REFERENCES colheita_estoque (id_colheita),
	id_pedido INTEGER REFERENCES pedido_venda (id)
);
\d item_pedido;

                                Tabela "public.item_pedido"
   Coluna   |  Tipo   | OrdenaþÒo | Pode ser nulo |                 PadrÒo
------------+---------+-----------+---------------+-----------------------------------------
 id         | integer |           | not null      | nextval('item_pedido_id_seq'::regclass)
 quantidade | integer |           | not null      |
 id_estoque | integer |           |               |
 id_pedido  | integer |           |               |
═ndices:
    "item_pedido_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "item_pedido_quantidade_check" CHECK (quantidade >= 0)
Restriþ§es de chave estrangeira:
    "item_pedido_id_estoque_fkey" FOREIGN KEY (id_estoque) REFERENCES colheita_estoque(id_colheita)
    "item_pedido_id_pedido_fkey" FOREIGN KEY (id_pedido) REFERENCES pedido_venda(id)

COMMIT;

// testando as tabelas ( antes de fazer o teste)


// tarbalho em 05/06/2024  
// verificando e testando tabelas existentes
\dt;
               Lista de relaþ§es
 Esquema |       Nome       |  Tipo  |   Dono
---------+------------------+--------+----------
 public  | cliente          | tabela | postgres
 public  | colheita_estoque | tabela | postgres
 public  | item_pedido      | tabela | postgres
 public  | pedido_venda     | tabela | postgres
 public  | plantio          | tabela | postgres
 public  | prodagricola     | tabela | postgres
 public  | produtor         | tabela | postgres
 public  | propriedade      | tabela | postgres

 // sem necessidade de mexer em produtor e prodAgricola (são simples sem checks)

 // arrumando o check da tabela id_propriedade
 SELECT * FROM propriedade;
  id | tamanho |     rua      | numero |     bairro      |     cidade     | estado |  email_proprietario  |    tipo     | area_plantada
----+---------+--------------+--------+-----------------+----------------+--------+----------------------+-------------+---------------
  4 |       3 | SAUDADE      |     12 | PARAISO         | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL |            -2
  5 |       7 | PEDRO II     |     75 | CENTRO          | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL |            -2
  6 |       9 | MINAS        |    789 | VILA TIBERIO    | CURITIBA       | PR     | poly@jis             | TRADICIONAL |            -2
  7 |      31 | CAXIAS       |     66 | CENTRO          | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL |            -2
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA    | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL |            -2
  9 |       7 | SAUDADE      |    835 | CENTRO          | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL |            -2
 12 |       7 | 7            |    568 | CENTRO          | Jau            | SP     | marcio@lol.com       | HIDROPONIA  |            -2
 13 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |            -2
 14 |      33 | Goias        |     12 | Campos Elisieos | Serrana        | MA     | cidao_p@bol.com      | HIDROPONIA  |            -2
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             3
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0
------------------------------------------------------
  // zerando todas as áreas plantadas

  BEGIN;
  UPDATE propriedade SET area_plantada = 0;
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
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             0
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0
(12 linhas)

COMMIT;
//OK!!
-----------------------
// ARRUMAR O CHECK PARA impedir números negativos na area_plantada

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



BEGIN;
ALTER TABLE propriedade
DROP CONSTRAINT "propriedade_check";
\d propriedade;
-> ═ndices:
	    "propriedade_pkey" PRIMARY KEY, btree (id)
	Restriþ§es de verificaþÒo:
	    "propriedade_tipo_check" CHECK (tipo::text = ANY (ARRAY['HIDROPONIA'::character varying, 'TRADICIONAL'::character varying]::text[]))
	Restriþ§es de chave estrangeira:
	    "propriedade_email_proprietario_fkey" FOREIGN KEY (email_proprietario) REFERENCES produtor(email)
	Referenciada por:
	    TABLE "plantio" CONSTRAINT "plantio_id_propriedade_fkey" FOREIGN KEY (id_propriedade) REFERENCES propriedade(id)
COMMIT;
    //ok

BEGIN;
ALTER TABLE propriedade
ADD CONSTRAINT "propriedade_check" CHECK (area_plantada <= tamanho AND area_plantada >= 0);

\d propriedade;
COMMIT;

//teste check
UPDATE propriedade SET area_plantada = -3;
->	ERRO:  a nova linha da relação "propriedade" viola a restrição de verificação "propriedade_check"
	DETALHE:  Registro que falhou contém (4, 3, SAUDADE, 12, PARAISO, PETROPOLIS, RJ, maiara@gamil.com, TRADICIONAL, -3).


// teste de área plantada em uma propriedade de tamanho 3 (tentativa de colocar area_plantada de 10 m²)
UPDATE propriedade SET area_plantada = 10
WHERE id = 4;
-> 	ERRO:  a nova linha da relação "propriedade" viola a restrição de verificação "propriedade_check"
	DETALHE:  Registro que falhou contém (4, 3, SAUDADE, 12, PARAISO, PETROPOLIS, RJ, maiara@gamil.com, TRADICIONAL, 10).
//ok tudo perfeito!!

----------------------------
// vamos dropar os outros bancos de dados para realizar os testes de integração 
// começamos com colheita_estoque
SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
           7 | 2024-05-29 10:23:10.776238 |         70 |           5.10 |         27
          12 | 2024-05-29 11:16:13.525705 |        250 |           7.00 |         28


 BEGIN;
 DELETE FROM colheita_estoque;
 SELECT * FROM colheita_estoque;
  id_colheita | data_colheita | quantidade | preco_unitario | id_plantio
-------------+---------------+------------+----------------+------------
(0 linha)
COMMIT;

// DELETANDO plantio
SELECT * FROM plantio;

BEGIN;
DELETE FROM plantio;
SELECT * FROM plantio;
 id | data_plantio | id_propriedade | id_prodagricola | area
----+--------------+----------------+-----------------+------
(0 linha)
COMMIT;
// OK!!

// deve se fazer uma trigger para que a cada item pedido (quantidade) seja descontado na tabela colheita_estoque


// trabalho de 07/06/24

// incluindo um check em quantidade para que seja sempre >= 0;

BEGIN;
ALTER TABLE colheita_estoque
ADD CONSTRAINT "quantidade_check" CHECK (quantidade >= 0);

\d colheita_estoque;
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
    "quantidade_check" CHECK (quantidade >= 0)
Restriþ§es de chave estrangeira:
    "colheita_estoque_id_plantio_fkey" FOREIGN KEY (id_plantio) REFERENCES plantio(id)
Referenciada por:
    TABLE "item_pedido" CONSTRAINT "item_pedido_id_estoque_fkey" FOREIGN KEY (id_estoque) REFERENCES colheita_estoque(id_colheita)
Gatilhos:
    descontar_area_plantada AFTER INSERT ON colheita_estoque FOR EACH ROW EXECUTE FUNCTION descontar_area()

COMMIT;

// ok!!

 // alterar valor padrão DA TABELA PEDIDO_VENDA do campo  'valor' para 0.00





BEGIN;
ALTER TABLE pedido_venda ALTER COLUMN valor SET DEFAULT 0.00;

\d pedido_venda;

                                           Tabela "public.pedido_venda"
    Coluna     |            Tipo             | OrdenaþÒo | Pode ser nulo |                  PadrÒo
---------------+-----------------------------+-----------+---------------+------------------------------------------
 id            | integer                     |           | not null      | nextval('pedido_venda_id_seq'::regclass)
 data          | timestamp without time zone |           | not null      |
 valor         | numeric(12,2)               |           |               | 0.00
 email_cliente | character varying(90)       |           |               |
═ndices:
    "pedido_venda_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "pedido_venda_valor_check" CHECK (valor >= 0::numeric)
Restriþ§es de chave estrangeira:
    "pedido_venda_email_cliente_fkey" FOREIGN KEY (email_cliente) REFERENCES cliente(email)
Referenciada por:
    TABLE "item_pedido" CONSTRAINT "item_pedido_id_pedido_fkey" FOREIGN KEY (id_pedido) REFERENCES pedido_venda(id)

 COMMIT;

// trabalho em 08/06/2024
// criar funções e trigger para as tabelas item_pedido e pedido_venda


BEGIN;

CREATE OR REPLACE FUNCTION descontar_quant()
RETURNS trigger AS
$$
	BEGIN
		
		UPDATE colheita_estoque
        SET quantidade = colheita_estoque.quantidade - NEW.quantidade
        
        FROM item_pedido
        WHERE colheita_estoque.id_colheita = NEW.id_estoque;
        

        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;
		

CREATE TRIGGER descontar_area_plantada
AFTER INSERT ON item_pedido 
	FOR EACH ROW
	EXECUTE FUNCTION descontar_quant(); 

COMMIT;

// feito agora hora de testar
// primeiro vamos incluir mais um registro na colheita;

BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 100, 6.00, 38);

select * from propriedade;
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
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             3
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0
(11 linhas)


COMMIT;

// SO FAR SO GOOD;
// VERIFICAÇÕES

SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         70 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |        100 |           6.00 |         38
SELECT * FROM info_colheita;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         70 |         35 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |        100 |         10 |           6.00
SELECT * FROM info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 37 |       5 | TRADICIONAL |             3 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622
 40 |       5 | TRADICIONAL |             3 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929

// DE 4 PLANTAÇÕES já foram colhidas 2 e essas duas estão disponíveis para venda em estoque;

// já podemos realizar um pedido e depois escolher os itens que vamos comprar. nesse sentido já vamos testar a primeira trigger

BEGIN;

INSERT INTO pedido_venda (data, email_cliente)
VALUES
(CURRENT_TIMESTAMP, 'filinha@papai.com');

SELECT * FROM pedido_venda;
 id |            data            | valor |   email_cliente
----+----------------------------+-------+-------------------
  1 | 2024-06-08 10:10:04.097249 |  0.00 | filinha@papai.com
(1 linha)


COMMIT;

// SO FAR SO PERFECT!!!
// vamos escolher os itens!!

BEGIN;

INSERT INTO item_pedido (quantidade, id_estoque, id_pedido)
VALUES
(2, 13, 1);

SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          14 | 2024-06-08 09:58:02.293266 |        100 |           6.00 |         38
          13 | 2024-06-07 05:56:29.687576 |    -> ->68 |<- <-      5.10 |         37 
SELECT * FROM item_pedido;
 id | quantidade | id_estoque | id_pedido
----+------------+------------+-----------
 11 |          2 |         13 |         1

 COMMIT;

 // OK!! agora fazer update no valor da tabela pedido_venda

BEGIN;

UPDATE pedido_venda
SET valor = colheita_estoque.preco_unitario * item_pedido.quantidade
FROM item_pedido, colheita_estoque
WHERE pedido_venda.id = item_pedido.id_pedido;

SELECT * FROM pedido_venda;
 id |            data            | valor |   email_cliente
----+----------------------------+-------+-------------------
  1 | 2024-06-08 10:10:04.097249 | 12.00 | filinha@papai.com
(1 linha)


COMMIT;

// então vamos fazer a função e trigger para atualizar o valor do pedido_venda

BEGIN;

CREATE OR REPLACE FUNCTION somar_valor()
RETURNS trigger AS
$$
	BEGIN
		
		UPDATE pedido_venda
		SET valor = pedido_venda.valor + (colheita_estoque.preco_unitario * NEW.quantidade) // fórmula incorreta
		FROM item_pedido, colheita_estoque
		WHERE pedido_venda.id = NEW.id_pedido;
		        

        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;
		

CREATE TRIGGER somar_valor_pedido
AFTER INSERT ON item_pedido 
	FOR EACH ROW
	EXECUTE FUNCTION somar_valor(); 

COMMIT;

// feito agora hora de testar
// 

BEGIN;

INSERT INTO item_pedido (quantidade, id_estoque, id_pedido)
VALUES
(5, 14, 1);

SELECT * FROM item_pedido;
 id | quantidade | id_estoque | id_pedido
----+------------+------------+-----------
 11 |          2 |         13 |         1
 12 |          5 |         14 |         1 <- <-
(2 linhas)


fazendau=*#
fazendau=*# SELECT * FROM pedido_venda;
 id |            data            | valor |   email_cliente
----+----------------------------+-------+-------------------
  1 | 2024-06-08 10:10:04.097249 | 37.50 | filinha@papai.com <- <-  o valor antes era 12.00
(1 linha)


fazendau=*#
fazendau=*# SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38 <- <- a quantidade era 100
(2 linhas)



COMMIT;

// perfect !!!

/*CREATE FUNCTION head_pedido
(IN id_do_pedido INTEGER, OUT data_pedido, OUT nome_cliente)

SELECT IP.quantidade, PA.nome AS produto, CE.valor_unitario, valor
	FROM item_pedido IP, plantio PL
	INNER JOIN  colheita_estoque CE
	ON (CE.id_colheita = IP.id_estoque)
	INNER JOIN prodAgricola PA
	ON (PA.id = PL.id_prodagricola AND PL.id = CE.id_plantio);*/
---------------------------------------------------------------------------------------------------------------
// trabalho em 09/06/2024

BEGIN;
CREATE VIEW pedido AS
	SELECT 	IP.id_pedido, IP.quantidade, IC.prod_agricola AS produto, IC.preco_unitario, (IP.quantidade * IC.preco_unitario) AS valor
		FROM  item_pedido IP
		INNER JOIN info_colheita IC
		ON (IC.id_colheita = IP.id_estoque)
		ORDER BY  IP.id_pedido;

fazendau=*# select * from pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+-------
         1 |          2 | ALFACE  |           5.10 | 10.20
         1 |          5 | COUVE   |           6.00 | 30.00
(2 linhas)


COMMIT;

SELECT PV.id AS pedido,Extract('DAY' From PV.data) AS dia, Extract('MONTH' From PV.data) AS mes,
 Extract('YEAR' From PV.data) AS ano, C.nome AS nome_cliente
	FROM pedido_venda PV
	INNER JOIN cliente C
	ON (C.emaiL = PV.email_cliente);


// detectado erro no função soma_valor() -> correção

 BEGIN;

CREATE OR REPLACE FUNCTION somar_valor()
RETURNS trigger AS
$$
    BEGIN
        
        UPDATE pedido_venda
        SET valor = pedido_venda.valor + ((SELECT preco_unitario FROM colheita_estoque WHERE colheita_estoque.id_colheita = NEW.id_estoque) * NEW.quantidade)
        FROM item_pedido, colheita_estoque
        WHERE pedido_venda.id = NEW.id_pedido;
                

        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

COMMIT;

// agora o update para corrigir o valor do pedido 1 de 37.50 para 40.20;

BEGIN;

UPDATE pedido_venda
SET valor = 40.20;

SELECT * FROM pedido_venda;

COMMIT;

// agora testar tudo!!!! 
// teste( mais 1 item no pedido 1 e 4 itens no novo pedido 2)

//antes vamos incluir um campo de status ('plantado' ou 'colhido') na tabela plantio 

BEGIN;

ALTER TABLE plantio
ADD status VARCHAR(30) DEFAULT 'plantado'
CHECK (status IN ('plantado', 'colhido'));

\d plantio;
     Coluna      |            Tipo             | OrdenaþÒo | Pode ser nulo |               PadrÒo
-----------------+-----------------------------+-----------+---------------+-------------------------------------
 id              | integer                     |           | not null      | nextval('plantio_id_seq'::regclass)
 data_plantio    | timestamp without time zone |           | not null      |
 id_propriedade  | integer                     |           |               |
 id_prodagricola | integer                     |           |               |
 area            | integer                     |           |               |
 status          | character varying(30)       |           |               | 'plantado'::character varying
═ndices:
    "plantio_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "plantio_check" CHECK (area > 0)
    "plantio_status_check" CHECK (status::text = ANY (ARRAY['plantado'::character varying, 'colhido'::character varying]::text[]))
Restriþ§es de chave estrangeira:
    "plantio_id_prodagricola_fkey" FOREIGN KEY (id_prodagricola) REFERENCES prodagricola(id)
    "plantio_id_propriedade_fkey" FOREIGN KEY (id_propriedade) REFERENCES propriedade(id)
Referenciada por:
    TABLE "colheita_estoque" CONSTRAINT "colheita_estoque_id_plantio_fkey" FOREIGN KEY (id_plantio) REFERENCES plantio(id)
Gatilhos:
    atualizar_area_plantada AFTER INSERT ON plantio FOR EACH ROW EXECUTE FUNCTION somar_area()

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | plantado
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | plantado
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | plantado
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | plantado
(4 linhas)

COMMIT;

// fazendo update para colocar as plantações que foram colhidas
SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38

BEGIN;

UPDATE plantio 
SET status = 'colhido'
WHERE id < 40;

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | plantado
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | plantado
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido

 COMMIT;
 colheita_estoque
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38

info_plantio
id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 40 |       5 | TRADICIONAL |             3 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929
 37 |       5 | TRADICIONAL |             3 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622

 //acertar função e trigget para ajustar o status apos insert em colheita

CREATE OR REPLACE FUNCTION alterar_status()
RETURNS trigger AS
$$
	BEGIN
		IF ((SELECT status FROM plantio WHERE NEW.id_plantio = plantio.id) = 'colhido') THEN
			DELETE FROM colheita_estoque WHERE id_colheita = NEW.id_colheita;
			RAISE EXCEPTION 'Esse plantio ja foi colhido';
			
		END IF;
		UPDATE plantio
		SET status = 'colhido'
		WHERE id = NEW.id_plantio;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER atualizar_status_plantio
AFTER INSERT ON colheita_estoque 
	FOR EACH ROW
	EXECUTE FUNCTION alterar_status(); 

// teste da trigger função 
BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 3, 4.00, 38);
ERRO:  Esse plantio j  foi colhido
CONTEXTO:  função PL/pgSQL alterar_status() linha 5 em RAISE
rollback;

BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 30, 10.00, 40),
('2024-05-31 12:30', 100, 4.00, 41);

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
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             0 <- <-
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0 <- <-
SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area | status
----+----------------------------+----------------+-----------------+------+---------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | colhido<- <-
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | colhido<- <-
SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38
          19 | 2024-06-09 07:06:54.773863 |         30 |          10.00 |         40 <- <-
          20 | 2024-05-31 12:30:00        |        100 |           4.00 |         41 <- <-

SELECT * FROM plantio;

COMMIT; 

SELECT * FROM INFO_COLHEITA;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         68 |         34 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |         95 |          9 |           6.00
          19 | 2024-01-01 08:00:00        | 2024-06-09 07:06:54.773863 | AGRIAO        |       3 |         30 |         10 |          10.00
          20 | 2024-06-06 16:13:00<- <-   | 2024-05-31 12:30:00  <- <- | COUVE         |      10 |        100 |         10 |           4.00 

// PROBLEMAS data do plantio posterior a data da colheita!!!!!

BEGIN;

UPDATE colheita_estoque 
SET data_colheita = CURRENT_TIMESTAMP
WHERE id_colheita = 20;

SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38
          19 | 2024-06-09 07:06:54.773863 |         30 |          10.00 |         40
          20 | 2024-06-09 07:42:58.674582 |        100 |           4.00 |         41
SELECT * FROM info_colheita;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         68 |         34 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |         95 |          9 |           6.00
          19 | 2024-01-01 08:00:00        | 2024-06-09 07:06:54.773863 | AGRIAO        |       3 |         30 |         10 |          10.00
          20 | 2024-06-06 16:13:00.019929 | 2024-06-09 07:42:58.674582 | COUVE         |      10 |        100 |         10 |           4.00

COMMIT;

// inserir mais 3 plantios

BEGIN;

INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-04-01 08:00:00', 2, 5, 5),
('2024-04-01 08:00:00', 3, 5, 4),
(CURRENT_TIMESTAMP, 10, 2, 1);

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | colhido
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | colhido
 43 | 2024-04-01 08:00:00        |              5 |               5 |    2 | plantado
 44 | 2024-04-01 08:00:00        |              5 |               4 |    3 | plantado
 45 | 2024-06-09 07:54:34.876319 |              2 |               1 |   10 | plantado

 SELECT * FROM info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 37 |       5 | TRADICIONAL |             0 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622
 40 |       5 | TRADICIONAL |             0 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929
 43 |       7 | TRADICIONAL |             5 | QUIABO        |       2 | 2024-04-01 08:00:00
 44 |       7 | TRADICIONAL |             5 | TOMATE        |       3 | 2024-04-01 08:00:00
 45 |      15 | HIDROPONIA  |            10 | ALFACE        |      10 | 2024-06-09 07:54:34.876319
(7 linhas)
 COMMIT;

 // ARRUMAR A QUESTÃO DA DATA MODIFICANDO A FUNÇÃO

CREATE OR REPLACE FUNCTION alterar_status()
RETURNS trigger AS
$$
	BEGIN
		IF ((SELECT status FROM plantio WHERE NEW.id_plantio = plantio.id) = 'colhido') THEN
			DELETE FROM colheita_estoque WHERE id_colheita = NEW.id_colheita;
			RAISE EXCEPTION 'Esse plantio ja foi colhido';
		
		END IF;

		IF ((SELECT data_plantio FROM plantio WHERE NEW.id_plantio = plantio.id) >= NEW.data_colheita) THEN
			DELETE FROM colheita_estoque WHERE id_colheita = NEW.id_colheita;
			RAISE EXCEPTION 'O plantio está no futuro da colheita, corrija a data_colheita';

		END IF;

		UPDATE plantio
		SET status = 'colhido'
		WHERE id = NEW.id_plantio;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

// testar a questão da data
BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
('2023-12-12 12:00:00', 30, 10.00, 45);
ERRO:  O plantio est  no futuro da colheita, corrija a data_colheita
CONTEXTO:  função PL/pgSQL alterar_status() linha 11 em RAISE

ROLLBACK;
//OK!


// incluir o tipo de propriedade / cidade / propriedade na view 'info_colheita' usar CREATE OR REPLACE VIEW

SELECT * FROM info_colheita;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         68 |         34 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |         95 |          9 |           6.00
          19 | 2024-01-01 08:00:00        | 2024-06-09 07:06:54.773863 | AGRIAO        |       3 |         30 |         10 |          10.00
          20 | 2024-06-06 16:13:00.019929 | 2024-06-09 07:42:58.674582 | COUVE         |      10 |        100 |         10 |           4.00

SELECT TO_CHAR(data_plantio , 'DD-MM-YY') AS data_plantio FROM plantio;
 data_plantio
--------------
 01-01-24
 06-06-24
 01-01-24
 06-06-24
 01-04-24
 01-04-24
 09-06-24
(7 linhas)



BEGIN;

CREATE OR REPLACE VIEW vitrine_venda AS
	SELECT CE.id_colheita, TO_CHAR(PL.data_plantio, 'DD-MM-YY') AS plantio, TO_CHAR(CE.data_colheita, 'DD-MM-YY') AS colheita,
	 AGR.nome AS prod_agricola, PL.area AS area_m2, CE.quantidade, (CE.quantidade/PL.area) AS rendimento, CE.preco_unitario, P.nome AS produtor,
	 PR.tipo, PR.cidade
		FROM colheita_estoque CE 
		INNER JOIN plantio PL
		ON (PL.id = CE.id_plantio)
		INNER JOIN prodAgricola AGR
		ON (AGR.id = PL.id_prodagricola)
		INNER JOIN propriedade PR
		ON (PR.id = PL.id_propriedade )
		INNER JOIN produtor P
		ON (P.email = PR.email_proprietario);

	

SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         68 |         34 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |         30 |         10 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |        100 |         10 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO

COMMIT;
// FOI CRIADA OUTRA VIEW SEM PROBLEMAS



fazendau=# select * from info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 37 |       5 | TRADICIONAL |             0 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622
 40 |       5 | TRADICIONAL |             0 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929
 43 |       7 | TRADICIONAL |             5 | QUIABO        |       2 | 2024-04-01 08:00:00
 44 |       7 | TRADICIONAL |             5 | TOMATE        |       3 | 2024-04-01 08:00:00
 45 |      15 | HIDROPONIA  |            10 | ALFACE        |      10 | 2024-06-09 07:54:34.876319
(7 linhas)


fazendau=# select * from plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | colhido
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | colhido
 43 | 2024-04-01 08:00:00        |              5 |               5 |    2 | plantado
 44 | 2024-04-01 08:00:00        |              5 |               4 |    3 | plantado
 45 | 2024-06-09 07:54:34.876319 |              2 |               1 |   10 | plantado

// vamos colher tomate e alface;
BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 30, 12.00, 44),
(CURRENT_TIMESTAMP, 80, 5.00, 45);

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | colhido
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | colhido
 43 | 2024-04-01 08:00:00        |              5 |               5 |    2 | plantado
 44 | 2024-04-01 08:00:00        |              5 |               4 |    3 | colhido
 45 | 2024-06-09 07:54:34.876319 |              2 |               1 |   10 | colhido
SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38
          19 | 2024-06-09 07:06:54.773863 |         30 |          10.00 |         40
          20 | 2024-06-09 07:42:58.674582 |        100 |           4.00 |         41
          22 | 2024-06-09 11:52:07.843    |         30 |          12.00 |         44
          23 | 2024-06-09 11:52:07.843    |         80 |           5.00 |         45
SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         68 |         34 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |         30 |         10 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |        100 |         10 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          22 | 01-04-24 | 09-06-24 | TOMATE        |       3 |         30 |         10 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO

COMMIT;

//OK

// VAMOS AGORA COLOCAR MAIS UM ITEM NO PEDIDO 1
select * from pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+-------
         1 |          2 | ALFACE  |           5.10 | 10.20
         1 |          5 | COUVE   |           6.00 | 30.00

BEGIN;

INSERT INTO item_pedido (quantidade, id_estoque, id_pedido)
VALUES
(10, 22, 1);

select * from pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+--------
         1 |          2 | ALFACE  |           5.10 |  10.20
         1 |          5 | COUVE   |           6.00 |  30.00
         1 |         10 | TOMATE  |          12.00 | 120.00 <- <- //SOMA OK
SELECT * FROM pedido_venda;
 id |            data            | valor   |   email_cliente
----+----------------------------+---------+-------------------
  1 | 2024-06-08 10:10:04.097249 |->160.20 | filinha@papai.com // SOMA OK
SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         68 |         34 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |         30 |         10 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |        100 |         10 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          22 | 01-04-24 | 09-06-24 | TOMATE <-     |       3 | sobra-> 20 |          6 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE
COMMIT;

// novo pedido 
BEGIN;

INSERT INTO pedido_venda (data, email_cliente)
VALUES
(CURRENT_TIMESTAMP, 'cesarfilho@sbt.com');

SELECT * FROM pedido_venda;
 id |            data            | valor  |   email_cliente
----+----------------------------+--------+--------------------
  1 | 2024-06-08 10:10:04.097249 | 160.20 | filinha@papai.com
  2 | 2024-06-09 12:11:09.57048  |   0.00 | cesarfilho@sbt.com
(2 linhas)


commit;

// por fim vamos colocar 4 itens no carrinho do imperador
BEGIN;

INSERT INTO item_pedido (quantidade, id_estoque, id_pedido)
VALUES
(8, 13, 2),
(5, 22, 2),
(15, 20, 2),
(30, 19, 2);

SELECT * FROM pedido_venda;
 id |            data            | valor  |   email_cliente
----+----------------------------+--------+--------------------
  1 | 2024-06-08 10:10:04.097249 | 160.20 | filinha@papai.com
  2 | 2024-06-09 12:11:09.57048  | 460.80 | cesarfilho@sbt.com
SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         60 |         30 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          22 | 01-04-24 | 09-06-24 | TOMATE        |       3 |         15 |          5 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |         85 |          8 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |          0 |          0 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS
(6 linhas)

SELECT * FROM pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+--------
         1 |          2 | ALFACE  |           5.10 |  10.20
         1 |          5 | COUVE   |           6.00 |  30.00
         1 |         10 | TOMATE  |          12.00 | 120.00
         2 |          8 | ALFACE  |           5.10 |  40.80
         2 |          5 | TOMATE  |          12.00 |  60.00
         2 |         15 | COUVE   |           4.00 |  60.00
         2 |         30 | AGRIAO  |          10.00 | 300.00

commit;

// ok



//view do cabeçalho
BEGIN;

CREATE OR REPLACE VIEW head_pedido AS
	SELECT PV.id AS pedido,Extract('DAY' From PV.data) AS dia, Extract('MONTH' From PV.data) AS mes,
	 Extract('YEAR' From PV.data) AS ano, C.nome AS nome_cliente
		FROM pedido_venda PV
		INNER JOIN cliente C
		ON (C.emaiL = PV.email_cliente);

SELECT * FROM head_pedido;
 pedido | dia | mes | ano  |    nome_cliente
--------+-----+-----+------+---------------------
      1 |   8 |   6 | 2024 | Ana Castela
      2 |   9 |   6 | 2024 | Cesar Filho Augusto
SELECT * FROM head_pedido WHERE pedido = 2;
 pedido | dia | mes | ano  |    nome_cliente
--------+-----+-----+------+---------------------
      2 |   9 |   6 | 2024 | Cesar Filho Augusto


commit;

// por fim (ufa!!!) vamos elaborar a nota do pedido da 'Ana Castela'

SELECT * FROM head_pedido WHERE pedido = 1;
SELECT * FROM PEDIDO WHERE id_pedido = 1;
SELECT valor AS total_compra FROM pedido_venda  WHERE id = 1;

 pedido | dia | mes | ano  | nome_cliente
--------+-----+-----+------+--------------
      1 |   8 |   6 | 2024 | Ana Castela

 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+--------
         1 |          5 | COUVE   |           6.00 |  30.00
         1 |          2 | ALFACE  |           5.10 |  10.20
         1 |         10 | TOMATE  |          12.00 | 120.00

 total_compra
--------------
       160.20

// trabalhando 10/06

// arrumando o view vitrine_pedido para não aparecer os itens zerados em quantidade

BEGIN;

CREATE OR REPLACE VIEW vitrine_venda AS
	SELECT CE.id_colheita, TO_CHAR(PL.data_plantio, 'DD-MM-YY') AS plantio, TO_CHAR(CE.data_colheita, 'DD-MM-YY') AS colheita,
	 AGR.nome AS prod_agricola, PL.area AS area_m2, CE.quantidade, (CE.quantidade/PL.area) AS rendimento, CE.preco_unitario, P.nome AS produtor,
	 PR.tipo, PR.cidade
		FROM colheita_estoque CE 
		INNER JOIN plantio PL
		ON (PL.id = CE.id_plantio)
		INNER JOIN prodAgricola AGR
		ON (AGR.id = PL.id_prodagricola)
		INNER JOIN propriedade PR
		ON (PR.id = PL.id_propriedade )
		INNER JOIN produtor P
		ON (P.email = PR.email_proprietario)
	WHERE CE.quantidade != 0;

SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         60 |         30 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          22 | 01-04-24 | 09-06-24 | TOMATE        |       3 |         15 |          5 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |         85 |          8 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO

// PERFEITO sem o 19 que estava com a quantidade zerada!

COMMIT;

