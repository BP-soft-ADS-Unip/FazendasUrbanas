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
---------------------------------------------------------------------
08/06/2024
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
----------------> vindo de pedido_venda L76
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

 // OK!! agora fazer update no valor da tabela pedido_venda --> ir para pedido_venda (há um erro vai ser corrigido depois)

------------------> vindo da pedido_venda L99
 BEGIN;

CREATE OR REPLACE FUNCTION somar_valor()
RETURNS trigger AS
$$
    BEGIN
        
        UPDATE pedido_venda
        SET valor = pedido_venda.valor + ((SELECT preco_unitario FROM colheita_estoque WHERE colheita_estoque.id_colheita = NEW.id_estoque) * NEW.quantidade) //este está correto
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

COMMIT

// feito agora hora de testar - o valor ficou errado pois a fórmula estava errada (como foi corrgida por aqui faço a crreção manualmente)

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
  1 | 2024-06-08 10:10:04.097249 | 40.20 | filinha@papai.com <- <-  o valor antes era 10.20 (10.20 + (5 * 6.00 ) = 40.20)
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


//terminou o dia 
-------------------> ir para view

-------------------> vindo de colheita_estoque L452

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

----------> ir para pedido_venda

---------> vindo de pedido_venda L123

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
  2 | 2024-06-09 12:11:09.57048  | 460.80 | cesarfilho@sbt.com <- <- soma correta
SELECT * FROM vitrine_venda;
 id_colheita | plantio  | colheita | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario |   produtor    |    tipo     |     cidade
-------------+----------+----------+---------------+---------+------------+------------+----------------+---------------+-------------+----------------
          14 | 06-06-24 | 08-06-24 | COUVE         |      10 |         95 |          9 |           6.00 | MARCELINO     | HIDROPONIA  | RIBEIRAO PRETO
          23 | 09-06-24 | 09-06-24 | ALFACE        |      10 |         80 |          8 |           5.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          13 | 01-01-24 | 07-06-24 | ALFACE        |       2 |sobra->  60 |         30 |           5.10 | Marcio        | TRADICIONAL | CAMPINAS
          22 | 01-04-24 | 09-06-24 | TOMATE        |       3 |sobra->  15 |          5 |          12.00 | MARCELINO     | TRADICIONAL | BELO HORIZONTE
          20 | 06-06-24 | 09-06-24 | COUVE         |      10 |sobra->  85 |          8 |           4.00 | Maria Thereza | HIDROPONIA  | RIBEIRAO PRETO
          19 | 01-01-24 | 09-06-24 | AGRIAO        |       3 |sobra->   0 |          0 |          10.00 | Marcio        | TRADICIONAL | CAMPINAS        -> -> zerou o estoque 
(6 linhas)

SELECT * FROM pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+--------
         1 |          2 | ALFACE  |           5.10 |  10.20
         1 |          5 | COUVE   |           6.00 |  30.00
         1 |         10 | TOMATE  |          12.00 | 120.00
         2 |          8 | ALFACE  |           5.10 |  40.80 <- <-
         2 |          5 | TOMATE  |          12.00 |  60.00 <- <-
         2 |         15 | COUVE   |           4.00 |  60.00 <- <-
         2 |         30 | AGRIAO  |          10.00 | 300.00 <- <-

commit;

// ok

// vamos elaborar uma view do cabeçalho da nota para complementar o view pedido

-------------------> ir para views
