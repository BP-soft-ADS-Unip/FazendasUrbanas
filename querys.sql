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


CREATE OR REPLACE FUNCTION somar_area()
RETURNS trigger
AS $$
	BEGIN
		UPDATE propriedade
		SET area_plantada = NEW.plantio.area + OLD.area_plantada
		WHERE id = NEW.plantio.id_propriedade;
		RETURN NULL;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_area_plantada
AFTER INSERT ON plantio 
	FOR EACH ROW EXECUTE PROCEDURE somar_area();

INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 2, 3, 1),
(CURRENT_TIMESTAMP, 10, 1, 2),
('2024-02-02 18:20:00', 25, 3, 1);