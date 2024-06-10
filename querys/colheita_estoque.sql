CREATE TABLE colheita_estoque (
	id_colheita SERIAL PRIMARY KEY,
	data_colheita TIMESTAMP NOT NULL,
	quantidade INTEGER NOT NULL,
	preco_unitario NUMERIC(10,2) NOT NULL CHECK (preco_unitario > 0),
	id_plantio INTEGER REFERENCES plantio (id)
	
	);

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
Restriþ§es de chave estrangeira:
    "colheita_estoque_id_plantio_fkey" FOREIGN KEY (id_plantio) REFERENCES plantio(id)
Referenciada por:
    TABLE "item_pedido" CONSTRAINT "item_pedido_id_estoque_fkey" FOREIGN KEY (id_estoque) REFERENCES colheita_estoque(id_colheita)

// ok!!


// criação função e trigger para descontar na area_plantada da tabela propriedade

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


CREATE TRIGGER descontar_area_plantada
AFTER INSERT ON colheita_estoque 
	FOR EACH ROW
	EXECUTE FUNCTION descontar_area();


COMMIT;

// TESTE inserir dados na tabela e conferir funcionamento função e trigger

SELECT * FROM plantio;
	 id |        data_plantio        | id_propriedade | id_prodagricola | area
	----+----------------------------+----------------+-----------------+------
->-> 37 | 2024-01-01 08:00:00        |              3 |               1 |    2  <- <-
	 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10
	 40 | 2024-01-01 08:00:00        |              3 |               3 |    3
	 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10
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
	  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10
->->  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             5 <- <-
	  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10


BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 70, 5.10, 37);

SELECT * FROM plantio;

SELECT* FROM propriedade;
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
	  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10
	  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10
->->  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             3 <- <-

COMMIT;

// ok!!

select * from colheita_estoque;

 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         70 |           5.10 |         37
(1 linha)
-----------------------
//08/06/2024
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
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |             0 <- <-
(11 linhas)
SELECT * FROM plantio;
	 id |        data_plantio        | id_propriedade | id_prodagricola | area
	----+----------------------------+----------------+-----------------+------
     37 | 2024-01-01 08:00:00        |              3 |               1 |    2  
->-> 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 <- <-
	 40 | 2024-01-01 08:00:00        |              3 |               3 |    3
	 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10

COMMIT;

// SO FAR SO GOOD;

// VERIFICAÇÕES

SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         70 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |        100 |           6.00 |         38 <- <-

SELECT * FROM info_colheita;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         70 |         35 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |        100 |         10 |           6.00 <- <-

SELECT * FROM info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 37 |       5 | TRADICIONAL |area agrião->3 | ALFACE        |       2 | 2024-01-01 08:00:100			<- colhida
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622      <- colhida
 40 |       5 | TRADICIONAL |             3 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929

// DE 4 PLANTAÇÕES já foram colhidas 2 e essas duas estão disponíveis para venda em estoque;

// já podemos realizar um pedido e depois escolher os itens que vamos comprar. nesse sentido já vamos testar a primeira trigger

-------> ir para pedido_venda 

---------> vindo de plantio L265

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

// teste da trigger função - testando o erro - tentando colher a já colhida
BEGIN;

INSERT INTO colheita_estoque (data_colheita, quantidade, preco_unitario, id_plantio)
VALUES
(CURRENT_TIMESTAMP, 3, 4.00, 38);

ERRO:  Esse plantio j  foi colhido
CONTEXTO:  função PL/pgSQL alterar_status() linha 5 em RAISE
rollback;
//ok!

// colhendo uma plantação e mudando automaticamente o status

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
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             0 <- <- (zerou a área plantada pois colheu!)
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0 <- <- (zerou a área plantada pois colheu!)
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

COMMIT; 


//DETECÇÃO DE ERRO!!!!!!!
SELECT * FROM INFO_COLHEITA;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         68 |         34 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |         95 |          9 |           6.00
          19 | 2024-01-01 08:00:00        | 2024-06-09 07:06:54.773863 | AGRIAO        |       3 |         30 |         10 |          10.00
          20 | 2024-06-06 16:13:00<- <-   | 2024-05-31 12:30:00  <- <- | COUVE         |      10 |        100 |         10 |           4.00 

// PROBLEMAS data do plantio posterior a data da colheita!!!!!


// PRIMEIRO VAMOS FAZER UM UPDATE NA DATA DE COLHEITA PARA CORRIGIR O REGISTRO

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
          20 | 2024-06-09 <- <-           |        100 |           4.00 |         41
SELECT * FROM info_colheita;
 id_colheita |        data_plantio        |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+----------------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00        | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         68 |         34 |           5.10
          14 | 2024-06-06 07:42:50.842622 | 2024-06-08 09:58:02.293266 | COUVE         |      10 |         95 |          9 |           6.00
          19 | 2024-01-01 08:00:00        | 2024-06-09 07:06:54.773863 | AGRIAO        |       3 |         30 |         10 |          10.00
          20 | 2024-06-06 <- <-           | 2024-06-09 <- <-           | COUVE         |      10 |        100 |         10 |           4.00 //AGORA FLUXO TEMPORAL PRESERVADO!! rs

COMMIT;

// para iniciar a correção do problema vamos inserir mais 3 plantios
--------------> ir para plantio

--------------> vindo de plantio L305
  // ARRUMAR A QUESTÃO DA DATA MODIFICANDO A FUNÇÃO
  // a trigger dessa função esta na linha 241 ( não precisa alterar continua igual)

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

// arrumar o view ( criar outro view para mostrar os produtos colhidos prontos para a venda)
-----------> ir para o view

---------> vindo de view L114
// vamos colher tomate e alface;

select * from info_plantio;
 id | tamanho |    tipo     | area_plantada | prod_agricola | area_m2 |        data_plantio
----+---------+-------------+---------------+---------------+---------+----------------------------
 37 |       5 | TRADICIONAL |             0 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |             0 | COUVE         |      10 | 2024-06-06 07:42:50.842622
 40 |       5 | TRADICIONAL |             0 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929
 43 |       7 | TRADICIONAL |             5 | QUIABO        |       2 | 2024-04-01 08:00:00
 44 |       7 | TRADICIONAL |             5 | TOMATE <- <-  |       3 | 2024-04-01 08:00:00
 45 |      15 | HIDROPONIA  |            10 | ALFACE <- <-  |      10 | 2024-06-09 07:54:34.876319
(7 linhas)


select * from plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area |  status
----+----------------------------+----------------+-----------------+------+----------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2 | colhido
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10 | colhido
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3 | colhido
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10 | colhido
 43 | 2024-04-01 08:00:00        |              5 |               5 |    2 | plantado
 44 | 2024-04-01 08:00:00        |              5 |               4 |    3 | plantado <- <-
 45 | 2024-06-09 07:54:34.876319 |              2 |               1 |   10 | plantado <- <-

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
 44 | 2024-04-01 08:00:00        |              5 |               4 |    3 | colhido <- <-
 45 | 2024-06-09 07:54:34.876319 |              2 |               1 |   10 | colhido <- <-
SELECT * FROM colheita_estoque;
 id_colheita |       data_colheita        | quantidade | preco_unitario | id_plantio
-------------+----------------------------+------------+----------------+------------
          13 | 2024-06-07 05:56:29.687576 |         68 |           5.10 |         37
          14 | 2024-06-08 09:58:02.293266 |         95 |           6.00 |         38
          19 | 2024-06-09 07:06:54.773863 |         30 |          10.00 |         40
          20 | 2024-06-09 07:42:58.674582 |        100 |           4.00 |         41
          22 | 2024-06-09 11:52:07.843    |         30 |          12.00 |         44 <- <-
          23 | 2024-06-09 11:52:07.843    |         80 |           5.00 |         45 <- <-
SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |         68 |         34 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |         30 |         10 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |        100 |         10 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          22 | 01-04-24 | 09-06-24 | TOMATE        |       3 |         30 |         10 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE <- <-
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO <- <-

COMMIT;

//OK

// VAMOS AGORA COLOCAR MAIS UM ITEM NO PEDIDO 1

-------------------> ir para item_pedido