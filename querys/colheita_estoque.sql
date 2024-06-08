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

