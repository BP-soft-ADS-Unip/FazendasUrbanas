CREATE TABLE prodAgricola (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL
	);

INSERT INTO prodAgricola(nome)
VALUES 
('ALFACE'),
('COUVE'),
('AGRIAO'),
('TOMATE'),
('QUIABO');

SELECT * FROM prodAgricola;

 id |  nome
----+--------
  1 | ALFACE
  2 | COUVE
  3 | AGRIAO
  4 | TOMATE
  5 | QUIABO
(5 linhas)

