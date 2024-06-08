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
 