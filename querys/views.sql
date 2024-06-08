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
          13 | 2024-01-01 08:00:00 | 2024-06-07 05:56:29.687576 | ALFACE        |       2 |         70 |         35 |           5.10j
COMMIT;