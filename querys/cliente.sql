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