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
//resolução; criar um campo área plantada na tabela propriedade e fazer um trigger para atualizar toda vez que iserir plantio
// fazer um check na área do plantio para ser menor ou igual a área plantada da tabela propriedade)
--------------------------
//fazer o check área plantio deve ser menor que a diferença do tamnaho e ára area_plantada
ALTER TABLE propriedade ADD
area_plantada INTEGER 
CHECK (area_plantada <= tamanho AND area_plantada >= 0);

---------------------------------
//fazer a trigger de atualização para somar valor valor na area_plantada da tabela propriedade toda vez que inserir valor no campo area da tabela plantio 

// antes deve se fazer a função

// 		CRETE TRIGGER atualizar_area_plantada
//		[before/after] [update] on tabela propriedade
//			for each [row/statement] execute procedure soma_area();

BEGIN;

/*
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
*/
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

CREATE TRIGGER atualizar_area_plantada
AFTER INSERT ON plantio 
	FOR EACH ROW
	EXECUTE FUNCTION somar_area(); 

BEGIN;

INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 2, 3, 1),
(CURRENT_TIMESTAMP, 10, 1, 2);

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10

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
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |             0
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             2
  1 |      25 | AURORA       |     35 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA  |            10

COMMIT;

//incluindo check para área maior ou igual a zero.


BEGIN;
ALTER TABLE plantio
ADD CONSTRAINT "plantio_check" CHECK (area > 0);
COMMIT;

//teste

BEGIN;
INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('1970-12-12 23:50:03', -4, 7, 3);

ERRO:  a nova linha da relação "plantio" viola a restrição de verificação "plantio_check"
DETALHE:  Registro que falhou contém (39, 1970-12-12 23:50:03, 7, 3, -4).

SELECT * FROM plantio;

SELECT * FROM propriedade;

ROLLBACK;

// TESTE OK!!
-----------------------------------------------------------
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
 
// para ver o codigo fonte de um função...
 SELECT prosrc
FROM pg_proc
WHERE proname = 'somar_area';

// MAIS TESTES - VERIFICANDO A SOMA DA area_plantada

BEGIN;
INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
('2024-01-01 08:00:00', 3, 3, 3),
(CURRENT_TIMESTAMP, 10, 2, 2);

SELECT * FROM plantio;
 id |        data_plantio        | id_propriedade | id_prodagricola | area
----+----------------------------+----------------+-----------------+------
 37 | 2024-01-01 08:00:00        |              3 |               1 |    2
 38 | 2024-06-06 07:42:50.842622 |              1 |               2 |   10
 40 | 2024-01-01 08:00:00        |              3 |               3 |    3
 41 | 2024-06-06 16:13:00.019929 |              2 |               2 |   10
(4 linhas)
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
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA     | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL |             5
  2 |      15 | AURORA       |    135 | VILA TIBERIO    | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA  |            10
(11 linhas)
COMMIT;

  // VERIFICANDO SE ACIONA O Gatilho (incluindo mais área do que o tamanho)

BEGIN;
INSERT INTO plantio (data_plantio, area, id_propriedade, id_prodAgricola)
VALUES
(CURRENT_TIMESTAMP, 10, 3, 2);

ERRO:  Area a ser inserida maior que a disponivel para plantio
CONTEXTO:  função PL/pgSQL somar_area() linha 5 em RAISE


ROLLBACK;


//OK!!


