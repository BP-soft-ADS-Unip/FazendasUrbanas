// para ver o codigo fonte de um função...
 SELECT prosrc
FROM pg_proc
WHERE proname = 'somar_area';


// criação do view informações do plantio

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
 37 |       5 | TRADICIONAL |             5 | ALFACE        |       2 | 2024-01-01 08:00:00
 38 |      25 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 07:42:50.842622
 40 |       5 | TRADICIONAL |             5 | AGRIAO        |       3 | 2024-01-01 08:00:00
 41 |      15 | HIDROPONIA  |            10 | COUVE         |      10 | 2024-06-06 16:13:00.019929

 // tudo 0k!!


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
 id_colheita |    data_plantio     |       data_colheita        | prod_agricola | area_m2 | quantidade | rendimento | preco_unitario
-------------+---------------------+----------------------------+---------------+---------+------------+------------+----------------
          13 | 2024-01-01 08:00:00 | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         70 |         35 |           5.10
COMMIT;

// trabalho em 09/06/2024
-------------------------> vindo de item_pedido L144

BEGIN;
CREATE VIEW pedido AS
	SELECT 	IP.id_pedido, IP.quantidade, IC.prod_agricola AS produto, IC.preco_unitario, (IP.quantidade * IC.preco_unitario) AS valor
		FROM  item_pedido IP
		INNER JOIN info_colheita IC
		ON (IC.id_colheita = IP.id_estoque)
		ORDER BY  IP.id_pedido;

select * from pedido;
 id_pedido | quantidade | produto | preco_unitario | valor
-----------+------------+---------+----------------+-------
         1 |          2 | ALFACE  |           5.10 | 10.20
         1 |          5 | COUVE   |           6.00 | 30.00
(2 linhas)


COMMIT;

// para ver o codigo fonte de um função...
 SELECT prosrc
FROM pg_proc
WHERE proname = 'somar_area';


--------------------------> ir para plantio 

---------------------------< vindo de colheita_estoque L381
// arrumar o view ( criar outro view para mostrar os produtos colhidos prontos para a venda)

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

-----------> ir para colheita_estoque

-------------> vindo de item_pedido L233

// vamos elaborar uma view do cabeçalho da nota para complementar o view pedido

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
---------------------------------------------------------
SELECT * FROM head_pedido WHERE pedido = 1;
SELECT * FROM PEDIDO WHERE id_pedido = 1;
SELECT valor AS total_compra FROM pedido_venda  WHERE id = 1;
---------------------------------------------------------------em um txt ficaria assim
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
------------------------------------------- 


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