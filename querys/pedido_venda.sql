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

 // alterar valor padrão do valor para 0

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
 ---------------------------------- de colheita_estoque linha 215
 08/06/2024
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

------------------------> indo para item_pedido
-------------------> vndo item_pedido L75

 // OK!! agora fazer update no valor da tabela pedido_venda

/*BEGIN;

UPDATE pedido_venda
SET valor = colheita_estoque.preco_unitario * item_pedido.quantidade
FROM item_pedido, colheita_estoque
WHERE pedido_venda.id = item_pedido.id_pedido;

SELECT * FROM pedido_venda;
 id |            data            | valor |   email_cliente
----+----------------------------+-------+-------------------
  1 | 2024-06-08 10:10:04.097249 | 12.00 | filinha@papai.com
(1 linha)


COMMIT;*/

// Há um erro acima pois foi multiplicado pelo preço unitário errado o valor seria 2 * 5,10 = 10.20

-----------> ir para item pedido para ver a trigger de soma valor do pedido venda

----------> vindo de item_pedido L185

// novo pedido

BEGIN;

INSERT INTO pedido_venda (data, email_cliente)
VALUES
(CURRENT_TIMESTAMP, 'cesarfilho@sbt.com');

SELECT * FROM pedido_venda;
 id |            data            | valor  |   email_cliente
----+----------------------------+--------+--------------------
  1 | 2024-06-08 10:10:04.097249 | 160.20 | filinha@papai.com
  2 | 2024-06-09 12:11:09.57048  |   0.00 | cesarfilho@sbt.com <- <-
(2 linhas)


commit;

// por fim vamos colocar 4 itens no carrinho do imperador

----------------------> ir para item_pedido

