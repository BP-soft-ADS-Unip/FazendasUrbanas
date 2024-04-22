/* creiando a database no postgre*/
CREATE DATABASE fazendaU;
/* selecionando a database*/
\c fazendau

CREATE TABLE PRODUTOR (
	EMAIL VARCHAR(90) NOT NULL PRIMARY KEY,
	CELULAR VARCHAR(15) NOT NULL,
	NOME VARCHAR(30) NOT NULL,
	SENHA VARCHAR(10) NOT NULL,
	UNIQUE (EMAIL)
);

INSERT INTO PRODUTOR VALUES(
	'mariathereza@uol.com', '459684', 'Maria Thereza', '10mtss');
INSERT INTO PRODUTOR VALUES(
	'joaoc@bol.com', '75752', 'Joao Candido', '8jcss');
INSERT INTO PRODUTOR VALUES(
	'maiara@gamil.com', '88531', 'maiara', '23mccs');
INSERT INTO PRODUTOR VALUES(
	'poly@jis', '881232', 'Polyana', 'poly');
INSERT INTO PRODUTOR VALUES(
	'marcio@lol.com', '225873', 'Marcio', '123456');

        email         | celular |     nome      | senha
----------------------+---------+---------------+--------
 MARCELINO@UNIP.BR    | 456123  | MARCELINO     | MKS&87
 mariathereza@uol.com | 459684  | Maria Thereza | 10mtss
 joaoc@bol.com        | 75752   | Joao Candido  | 8jcss
 maiara@gamil.com     | 88531   | maiara        | 23mccs
 poly@jis             | 881232  | Polyana       | poly
 marcio@lol.com       | 225873  | Marcio        | 123456

 CREATE TABLE PROPRIEDADE (
 	ID SERIAL PRIMARY KEY,
 	TAMANHO INTEGER NOT NULL,
 	RUA VARCHAR(90) NOT NULL,
 	NUMERO INTEGER,
 	BAIRRO VARCHAR(40),
 	CIDADE VARCHAR(40) NOT NULL,
 	ESTADO VARCHAR(2),
 	EMAIL_PROPRIETARIO VARCHAR(90) REFERENCES PRODUTOR (EMAIL)

 	);

 INSERT INTO PROPRIEDADE (TAMANHO, RUA, NUMERO, BAIRRO, CIDADE, ESTADO, EMAIL_PROPRIETARIO)
 VALUES
 (25, 'AURORA', 35, 'VILA TIBERIO', 'RIBEIRAO PRETO', 'SP', 'MARCELINO@UNIP.BR'),
 (15, 'AURORA', 135, 'VILA TIBERIO', 'RIBEIRAO PRETO', 'SP', 'mariathereza@uol.com'),
 (5, 'GOIAS', 935, 'NOVA ALINÇA', 'CAMPINAS', 'SP', 'marcio@lol.com'),
 (3, 'SAUDADE', 12, 'PARAISO', 'PETROPOLIS', 'RJ', 'maiara@gamil.com'),
 (7, 'PEDRO II', 75, 'CENTRO', 'BELO HORIZONTE', 'MG', 'MARCELINO@UNIP.BR'),
 (9, 'MINAS', 789, 'VILA TIBERIO', 'CURITIBA', 'PR', 'poly@jis'),
 (31, 'CAXIAS', 66, 'CENTRO', 'SÃO PAULO', 'SP', 'maiara@gamil.com'),
 (10, 'CARLOS GOMES', 38, 'VILA AUGUSTA', 'SÃO PAULO', 'SP', 'MARCELINO@UNIP.BR'),
 (7, 'SAUDADE', 835, 'CENTRO', 'CAMPO GRANDE', 'MS', 'joaoc@bol.com');

 SELECT P.NOME, PDE.RUA, PDE.BAIRRO, PDE.CIDADE, P.CELULAR, PDE.TAMANHO AS AREA
 FROM PRODUTOR P 
 INNER JOIN PROPRIEDADE PDE 
 ON P.EMAIL = PDE.EMAIL_PROPRIETARIO;

     nome      |     rua      |    bairro    |     cidade     | celular | area
---------------+--------------+--------------+----------------+---------+------
 MARCELINO     | AURORA       | VILA TIBERIO | RIBEIRAO PRETO | 456123  |   25
 Maria Thereza | AURORA       | VILA TIBERIO | RIBEIRAO PRETO | 459684  |   15
 Marcio        | GOIAS        | NOVA ALINÇA  | CAMPINAS       | 225873  |    5
 maiara        | SAUDADE      | PARAISO      | PETROPOLIS     | 88531   |    3
 MARCELINO     | PEDRO II     | CENTRO       | BELO HORIZONTE | 456123  |    7
 Polyana       | MINAS        | VILA TIBERIO | CURITIBA       | 881232  |    9
 maiara        | CAXIAS       | CENTRO       | SÃO PAULO      | 88531   |   31
 MARCELINO     | CARLOS GOMES | VILA AUGUSTA | SÃO PAULO      | 456123  |   10
 Joao Candido  | SAUDADE      | CENTRO       | CAMPO GRANDE   | 75752   |    7