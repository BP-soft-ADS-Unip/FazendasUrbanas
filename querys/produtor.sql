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

--------------------------------------------
  ALTER TABLE produtor ADD
 chave_pix VARCHAR (255);

 TABLE "propriedade" CONSTRAINT "propriedade_email_proprietario_fkey" FOREIGN KEY (email_proprietario) REFERENCES produtor(email)

 SELECT * FROM produtor;
        email         | celular |      nome       | senha  | chave_pix
----------------------+---------+-----------------+--------+-----------
 MARCELINO@UNIP.BR    | 456123  | MARCELINO       | MKS&87 |
 mariathereza@uol.com | 459684  | Maria Thereza   | 10mtss |
 joaoc@bol.com        | 75752   | Joao Candido    | 8jcss  |
 maiara@gamil.com     | 88531   | maiara          | 23mccs |
 poly@jis             | 881232  | Polyana         | poly   |
 marcio@lol.com       | 225873  | Marcio          | 123456 |
 BIA@UOL              | 456897  | beatriz         | 12345  |
 marta@bol            | 456897  | marta           | 12345  |
 jose@ui              | 4569822 | JOSE            | 1234   |
 cidao@bol.com        | 9969822 | aparecido       | 1234   |
 cidao_p@bol.com      | 9969822 | aparecido Paulo | 1234   |
 PAULOM@UNIP.BR       | 56369   | Paulo Modas     | abc    |

 ------------------------------------------------------------------------------------------------