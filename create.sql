-- REQUISITOS DA CHECKLIST ATENDIDOS NESSE ARQUIVO
-- 1. CREATE OR REPLACE
-- 2. CREATE OR REPLACE BODY
-- 3. MEMBER PROCEDURE
-- 4. MEMBER FUNCTION
-- 5. ORDER MEMBER FUNCTION
-- 6. MAP MEMBER FUNCTION
-- 7. CONSTRUCTOR FUNCTION
-- 8. OVERRIDING MEMBER
-- 9. FINAL MEMBER
-- 10. NOT INSTANTIABLE TYPE/MEMBER
-- 11. HERANÇA DE TIPOS (UNDER/NOT FINAL)
-- 12. ALTER TYPE
-- 13. CREATE TABLE OF
-- 14. WITH ROWID REFERENCES
-- 15. REF
-- 16. SCOPE IS
-- 17. VARRAY
-- 18. CONSULTA A VARRAY
-- 19. NESTED TABLE
-- 20. CONSULTA A NESTED TABLE

CREATE OR REPLACE TYPE tp_fone AS OBJECT(
    cod_pais VARCHAR2(3),
    cod_area VARCHAR2(3)
    --numero VARCHAR2(20)
);
/
ALTER TYPE tp_fone ADD ATTRIBUTE (numero VARCHAR2(20)) CASCADE;

CREATE OR REPLACE TYPE tp_fones AS VARRAY(5) OF tp_fone;
/

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    cpf VARCHAR2(20), 
	nome VARCHAR2(50), 
	email VARCHAR2(40),
	telefones tp_fones,
	MEMBER PROCEDURE exibir_fones,
	MAP MEMBER FUNCTION pessoaTOnome RETURN VARCHAR2
) NOT FINAL NOT INSTANTIABLE;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE TYPE BODY tp_pessoa AS  
    
    MEMBER PROCEDURE exibir_fones IS  
      
    BEGIN  
        FOR reg IN (SELECT T.* FROM TABLE(telefones) T) LOOP  
        DBMS_OUTPUT.PUT_LINE(nome ||' '|| TO_CHAR(reg.cod_area) || ' ' || TO_CHAR(reg.numero));  
        end loop;
    END;  
    
    MAP MEMBER FUNCTION pessoaTOnome RETURN VARCHAR2  
    IS  
    retorno VARCHAR2(50);  
    BEGIN  
        retorno := nome;  
        RETURN retorno;  
    END;  
END; 
/
-------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE tp_gestor UNDER tp_pessoa(
);
/

CREATE OR REPLACE TYPE tp_funcionario UNDER tp_pessoa(
    cargo VARCHAR2(30), 
	salario FLOAT, 
	data_admissao DATE, 
	data_demissao DATE,
	OVERRIDING MEMBER PROCEDURE exibir_fones
);
/

--------------------------------------------------------------------------------------
CREATE OR REPLACE TYPE BODY tp_funcionario AS  
    
    OVERRIDING MEMBER PROCEDURE exibir_fones IS  
      
    BEGIN  
        FOR reg IN (SELECT T.* FROM TABLE(telefones) T) LOOP  
        DBMS_OUTPUT.PUT_LINE(cargo || ' ' || nome ||' '|| TO_CHAR(reg.cod_area) || ' ' || TO_CHAR(reg.numero));  
        END LOOP;
    END;
END;
/
--------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
   	rua VARCHAR2(50), 
	numero NUMBER, 
	complemento VARCHAR2(50), 
	bairro VARCHAR2(50), 
	cidade VARCHAR2(50), 
	estado VARCHAR2(30), 
	pais VARCHAR2(30), 
	cod_postal VARCHAR(20),
CONSTRUCTOR FUNCTION tp_endereco(SELF IN OUT NOCOPY tp_endereco, rua VARCHAR2, numero NUMBER, bairro VARCHAR2, cidade VARCHAR2, estado VARCHAR2, pais VARCHAR2, cod_postal VARCHAR) RETURN SELF AS RESULT
) NOT FINAL;
/

CREATE TYPE BODY tp_endereco AS
	CONSTRUCTOR FUNCTION tp_endereco(SELF IN OUT NOCOPY tp_endereco, rua VARCHAR2, numero NUMBER, bairro VARCHAR2, cidade VARCHAR2, estado VARCHAR2, pais VARCHAR2, cod_postal VARCHAR) RETURN SELF AS RESULT IS
	BEGIN
		SELF.rua := rua;
		SELF.numero := numero;	
		SELF.bairro := bairro;
		SELF.cidade := cidade;
		SELF.estado := estado;
		SELF.pais := pais;
		SELF.cod_postal := cod_postal;
		RETURN;
	END;
END;
/


CREATE OR REPLACE TYPE tp_condominio AS OBJECT(
    codigo NUMBER, 
	nome VARCHAR2(50), 
	data_abertura DATE,
	endereco tp_endereco
);
/

CREATE OR REPLACE TYPE tp_apartamento AS OBJECT(
    cond REF tp_condominio, 
    codigo_cond NUMBER,
	bloco VARCHAR2(7), 
	numero NUMBER, 
	andar NUMBER,
	ORDER MEMBER FUNCTION por_numero (x tp_apartamento) RETURN NUMBER
);
/

-------------------------------------------------------------------------------------
CREATE OR REPLACE TYPE BODY tp_apartamento AS
    
    ORDER MEMBER FUNCTION por_numero (x tp_apartamento) RETURN NUMBER  
    IS  
    retorno NUMBER;  
    BEGIN  
        retorno := self.numero - x.numero;  
        RETURN retorno;  
    END;  
END; 
/
-------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE tp_casa AS OBJECT(
    apartamento REF tp_apartamento,
    proprietario NUMBER(1),
    data_entrada DATE,
    data_saida DATE
);
/

CREATE OR REPLACE TYPE tp_moradias AS TABLE OF tp_casa;
/

CREATE OR REPLACE TYPE tp_morador UNDER tp_pessoa(
    casas tp_moradias
);
/

CREATE OR REPLACE TYPE tp_espaco AS OBJECT(
    cond REF tp_condominio,
    codigo_cond NUMBER,
    nome VARCHAR2(30), 
	capacidade_max NUMBER, 
	horario_abertura INTERVAL DAY(0) TO SECOND(0),
    horario_fechamento INTERVAL DAY(0) TO SECOND(0), 
	publico NUMBER(1)
);
/
CREATE OR REPLACE TYPE tp_pessoa_ref AS OBJECT(
	individuo REF tp_pessoa
);
/

CREATE OR REPLACE TYPE tp_pessoas AS TABLE OF tp_pessoa_ref;
/

CREATE OR REPLACE TYPE tp_ocorrencia AS OBJECT(
    autor REF tp_pessoa,
    cond REF tp_condominio,
    gestor_que_resolveu REF tp_gestor,
    protocolo      NUMBER,
    data_hora      TIMESTAMP,
    mensagem       VARCHAR2(2000),
    data_hora_res  TIMESTAMP,
    mensagem_res   VARCHAR2(2000),
    pessoas_citadas tp_pessoas,
    FINAL MEMBER FUNCTION quantas_pessoas_cita RETURN INTEGER
);
/

-------------------------------------------------------------------------
CREATE OR REPLACE TYPE BODY tp_ocorrencia AS
    FINAL MEMBER FUNCTION quantas_pessoas_cita RETURN INTEGER IS
    numero INTEGER;
    BEGIN
        SELECT COUNT(*) INTO numero FROM TABLE(pessoas_citadas) ;
        RETURN numero;
    END;
END;
/
---------------------------------------------------------------------------------

CREATE OR REPLACE TYPE tp_relac_gerencia AS OBJECT(
    gestor REF tp_gestor,
    cond REF tp_condominio,
    cpf_gestor VARCHAR2(20),
    codigo_cond NUMBER,
    cargo VARCHAR2(20), 
	data_inicio DATE, 
	data_termino DATE
);
/


CREATE OR REPLACE TYPE tp_relac_trabalha AS OBJECT(
    funcionario REF tp_funcionario,
    cond REF tp_condominio,
    cpf VARCHAR(20),
    data_admissao DATE,
    cod_c NUMBER,
    data_inicio DATE,
    data_termino DATE
);
/

CREATE OR REPLACE TYPE tp_relac_avalia AS OBJECT(
    avaliador_cpf VARCHAR(20),
    avaliado_cpf VARCHAR(20),
    avaliador REF tp_gestor,
    avaliado REF tp_gestor,
    data_hora TIMESTAMP,
    mensagem VARCHAR2(2000)
);
/

CREATE OR REPLACE TYPE tp_relac_reserva AS OBJECT(
    pessoa_cpf VARCHAR2(20),
    espaco_cod_cond NUMBER,
    espaco_nome VARCHAR2(30),
    pessoa REF tp_pessoa,
    espaco REF tp_espaco,
    gestor REF tp_gestor,
    data_hora_inicio TIMESTAMP,
    duracao_minutos NUMBER(4)
);
/

CREATE TABLE tb_morador OF tp_morador(
    cpf PRIMARY KEY,
    nome NOT NULL
) NESTED TABLE casas STORE AS tb_nt_casas;
/

CREATE TABLE tb_gestor OF tp_gestor(
    cpf PRIMARY KEY,
    nome NOT NULL
);
/

CREATE TABLE tb_funcionario OF tp_funcionario(
    CONSTRAINT func_pk PRIMARY KEY (cpf, data_admissao),
    nome NOT NULL
);
/

CREATE TABLE tb_condominio OF tp_condominio(
    codigo PRIMARY KEY,
    nome NOT NULL,
    endereco NOT NULL
);
/

CREATE TABLE tb_apartamento OF tp_apartamento(
    CONSTRAINT ap_pk PRIMARY KEY (codigo_cond, bloco, numero),
    cond WITH ROWID REFERENCES tb_condominio NOT NULL
);
/


CREATE TABLE tb_espaco OF tp_espaco (
    CONSTRAINT esp_pk PRIMARY KEY (codigo_cond, nome)
);
/

CREATE TABLE tb_ocorrencia OF tp_ocorrencia (
    protocolo PRIMARY KEY,
    autor WITH ROWID NOT NULL,
    cond WITH ROWID REFERENCES tb_condominio NOT NULL
)
NESTED TABLE pessoas_citadas STORE AS tb_nt_citadas;
/


CREATE TABLE tb_gerencia OF tp_relac_gerencia (
    data_inicio NOT NULL,
    CONSTRAINT gerencia_pk PRIMARY KEY (cpf_gestor, codigo_cond, cargo, data_inicio)
);
/

CREATE TABLE tb_trabalha OF tp_relac_trabalha (
    CONSTRAINT trabalha_pk PRIMARY KEY (cpf, data_admissao, cod_c),
    funcionario WITH ROWID REFERENCES tb_funcionario,
    cond WITH ROWID REFERENCES tb_condominio
);
/

CREATE TABLE tb_avalia OF tp_relac_avalia (
    CONSTRAINT avalia_pk PRIMARY KEY (avaliador_cpf, avaliado_cpf, data_hora),
    avaliador SCOPE IS tb_gestor
);
/

CREATE TABLE tb_reserva OF tp_relac_reserva(
	CONSTRAINT reserva_pk PRIMARY KEY(pessoa_cpf, espaco_cod_cond, espaco_nome, data_hora_inicio),
	gestor WITH ROWID REFERENCES tb_gestor
);
