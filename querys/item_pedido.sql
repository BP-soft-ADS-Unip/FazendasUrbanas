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

