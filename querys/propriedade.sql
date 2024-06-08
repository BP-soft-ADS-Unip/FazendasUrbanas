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


// inner join de produtor e propriedade (cadidaa a view)

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

// inclusão do campo 'tipo' com check de apenas duas formas só em caixa alta
 ALTER TABLE PROPRIEDADE 
 ADD TIPO VARCHAR(20) 
 CHECK (TIPO IN ('HIDROPONIA', 'TRADICIONAL'));

//teste
 UPDATE PROPRIEDADE SET TIPO = 'E_NOIS';
 ERRO:  a nova linha da relação "propriedade" viola a restrição de verificação "propriedade_tipo_check"
DETALHE:  Registro que falhou contém (1, 25, AURORA, 35, VILA TIBERIO, RIBEIRAO PRETO, SP, MARCELINO@UNIP.BR, E_NOIS).
// ok!!


UPDATE PROPRIEDADE
SET TIPO = 'HIDROPONIA'
WHERE CIDADE = 'RIBEIRAO PRETO';

UPDATE PROPRIEDADE
SET TIPO = 'TRADICIONAL'
WHERE CIDADE != 'RIBEIRAO PRETO';

 id | tamanho |     rua      | numero |    bairro    |     cidade     | estado |  email_proprietario  |    tipo
----+---------+--------------+--------+--------------+----------------+--------+----------------------+-------------
  1 |      25 | AURORA       |     35 | VILA TIBERIO | RIBEIRAO PRETO | SP     | MARCELINO@UNIP.BR    | HIDROPONIA
  2 |      15 | AURORA       |    135 | VILA TIBERIO | RIBEIRAO PRETO | SP     | mariathereza@uol.com | HIDROPONIA
  3 |       5 | GOIAS        |    935 | NOVA ALINÇA  | CAMPINAS       | SP     | marcio@lol.com       | TRADICIONAL
  4 |       3 | SAUDADE      |     12 | PARAISO      | PETROPOLIS     | RJ     | maiara@gamil.com     | TRADICIONAL
  5 |       7 | PEDRO II     |     75 | CENTRO       | BELO HORIZONTE | MG     | MARCELINO@UNIP.BR    | TRADICIONAL
  6 |       9 | MINAS        |    789 | VILA TIBERIO | CURITIBA       | PR     | poly@jis             | TRADICIONAL
  7 |      31 | CAXIAS       |     66 | CENTRO       | SÃO PAULO      | SP     | maiara@gamil.com     | TRADICIONAL
  8 |      10 | CARLOS GOMES |     38 | VILA AUGUSTA | SÃO PAULO      | SP     | MARCELINO@UNIP.BR    | TRADICIONAL
  9 |       7 | SAUDADE      |    835 | CENTRO       | CAMPO GRANDE   | MS     | joaoc@bol.com        | TRADICIONAL

 INSERT INTO PROPRIEDADE(RUA, BAIRRO, CIDADE, ESTADO, TIPO, EMAIL_PROPRIETARIO, NUMERO, TAMANHO) 
 VALUES ('7', 'CENTRO', 'Jau', 'SP', 'HIDROPONIA', 'marcio@lol.com', 568, 7);

----------------------------------
// ATENÇÃO!!!!! CASE SENSITIVE - NÃO ACHOU POIS O EMAIL ESTA EM CAIXA ALTA
 SELECT * FROM PRODUTOR WHERE EMAIL = 'marcelino@unip.br';
  email | celular | nome | senha | chave_pix
-------+---------+------+-------+-----------
(0 linha)
-------------------------------------------
// criação do campo area_plantada com check

ALTER TABLE propriedade ADD
area_plantada INTEGER 
CHECK (area_plantada <= tamanho AND area_plantada >= 0);

\d propriedade;

                                           Tabela "public.propriedade"
       Coluna       |         Tipo          | OrdenaþÒo | Pode ser nulo |                 PadrÒo
--------------------+-----------------------+-----------+---------------+-----------------------------------------
 id                 | integer               |           | not null      | nextval('propriedade_id_seq'::regclass)
 tamanho            | integer               |           | not null      |
 rua                | character varying(90) |           | not null      |
 numero             | integer               |           |               |
 bairro             | character varying(40) |           |               |
 cidade             | character varying(40) |           | not null      |
 estado             | character varying(2)  |           |               |
 email_proprietario | character varying(90) |           |               |
 tipo               | character varying(20) |           |               |
 area_plantada      | integer               |           |               |
═ndices:
    "propriedade_pkey" PRIMARY KEY, btree (id)
Restriþ§es de verificaþÒo:
    "propriedade_check" CHECK (area_plantada <= tamanho AND area_plantada >= 0)
    "propriedade_tipo_check" CHECK (tipo::text = ANY (ARRAY['HIDROPONIA'::character varying, 'TRADICIONAL'::character varying]::text[]))

------------------------------------------------


