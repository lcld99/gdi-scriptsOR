-- REQUISITOS DA CHECKLIST ATENDIDOS NESSE ARQUIVO
-- 1. INSERT INTO
-- 2. SELECT REF
-- 3. VALUE


--CONDOMINIOS

INSERT INTO tb_condominio VALUES(tp_condominio(1, 'Condominio Bonito', TO_DATE('10-JAN-02', 'yyyy/mm/dd'), tp_endereco('Rua Vila Francisca',14,'Bairro Terra Firme','Belém','Pará','Brasil','66077195')));


INSERT INTO tb_condominio VALUES(tp_condominio(2, 'Vale da Saudade', TO_DATE('2003/07/09', 'yyyy/mm/dd'), tp_endereco('rua da paz', 35, 'piedade', 'jaboatao dos guararapes', 'pernambuco', 'brasil', '54520150')));

--APARTAMENTOS

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 1, 1);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 2, 1);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 3, 2);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 4, 2);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 5, 3);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'UM', 6, 3);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 1, 1);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 2, 1);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 3, 2);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 4, 2);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 5, 3);

INSERT INTO tb_apartamento VALUES ((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'DOIS', 6, 3);



INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'A', 1, 1);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'A', 2, 1);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'A', 3, 2);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'A', 4, 2);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'B', 1, 1);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'B', 2, 1);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'B', 3, 2);

INSERT INTO tb_apartamento VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'B', 4, 2);


-- ESPAÇOS

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'Salão de Festas', 50, INTERVAL '08:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 0);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'Piscina', 30, INTERVAL '06:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 0);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'Espaço Gourmet', 20, INTERVAL '09:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 1);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), 1, 'Playground', 15, INTERVAL '07:00' HOUR TO MINUTE, INTERVAL '20:00' HOUR TO MINUTE, 0);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'Academia', 12,  INTERVAL '05:00' HOUR TO MINUTE, INTERVAL '23:00' HOUR TO MINUTE, 1);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'Piscina', 30,  INTERVAL '05:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 1);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'Horta Comunitária', NULL,  INTERVAL '05:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 1);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'Salão de jogos', 35,  INTERVAL '08:00' HOUR TO MINUTE, INTERVAL '22:00' HOUR TO MINUTE, 1);

INSERT INTO tb_espaco VALUES((SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), 2, 'Salão de festas', 75,  INTERVAL '08:00' HOUR TO MINUTE, INTERVAL '23:00' HOUR TO MINUTE, 0);






-- MORADORES


INSERT INTO tb_morador VALUES (tp_morador('12345678999','Heitor Andrade','heitorand@hotmail.com',tp_fones(tp_fone('55','81','998765432')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 1 AND bloco = 'A' AND numero = 1), 1,  TO_DATE('2009/09/11', 'yyyy/mm/dd'), NULL ))));


INSERT INTO tb_morador VALUES (tp_morador('77777777777', 'Cristiano ronaldo', 'cr7@outlook.com', tp_fones(tp_fone('77', '77', '977777777'), tp_fone('55', '81', '974747474')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 2 AND bloco = 'UM' AND numero = 1), 1, TO_DATE('2013/07/09', 'yyyy/mm/dd'), NULL))));

INSERT INTO tb_morador VALUES (tp_morador('5555555555', 'Maria bonita', 'bonita@outlook.com', tp_fones(tp_fone('40', '20', '971024870'), tp_fone('55', '81', '9221504577')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 2 AND bloco = 'UM' AND numero = 2), 1, TO_DATE('2017/01/29', 'yyyy/mm/dd'), NULL))));

INSERT INTO tb_morador VALUES (tp_morador('10101010101', 'LIONEL MESSI', 'lm10@hotmail,com', tp_fones(tp_fone('10', '21', '910101010')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 2 AND bloco = 'DOIS' AND numero = 4), 1, TO_DATE('2013/07/09', 'yyyy/mm/dd'), NULL), tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 2 AND bloco = 'DOIS' AND numero = 3), 1, TO_DATE('2013/07/09', 'yyyy/mm/dd'), NULL))));

INSERT INTO tb_morador VALUES (tp_morador('11111111111', 'Roberto Carlos', 'robc@gmail.com', tp_fones(tp_fone('55', '81', '911111111'), tp_fone('55', '87', '911223344')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 1 AND bloco = 'A' AND numero = 3), 1, TO_DATE('2015/02/02', 'yyyy/mm/dd'), NULL))));

INSERT INTO tb_morador VALUES (tp_morador('22222222222', 'Marta Holanda', 'hollmarta@hotmail.com', tp_fones(tp_fone('55', '81', '992999299')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 1 AND bloco = 'B' AND numero = 3), 1, TO_DATE('2003/01/10', 'yyyy/mm/dd'), NULL))));

INSERT INTO tb_morador VALUES (tp_morador('33333333333', 'José Coelho', 'ze_coelho@gmail.com', tp_fones(tp_fone('55', '81', '997638599'), tp_fone('55', '81', '988859567')), tp_moradias(tp_casa((SELECT REF(A) FROM tb_apartamento A WHERE codigo_cond = 1 AND bloco = 'A' AND numero = 1), 0, TO_DATE('2010/01/08', 'yyyy/mm/dd'), NULL))));



-- GESTOR

INSERT INTO tb_gestor VALUES('54985978594','Jorge Henrique', 'jorginho@yahoo.com', tp_fones((tp_fone('55','81','988456565')),(tp_fone('55','81','988956969')))
);

INSERT INTO tb_gestor VALUES('55468594785','Sasha Karen', 'sashashow@gmail.com', tp_fones(tp_fone('55','81','988456565'))
);

INSERT INTO tb_gestor VALUES('12345678910', 'EDMUNDO SOUZA', 'edmundosouza7@gamil.com', tp_fones(tp_fone('55', '11', '47758547')));

INSERT INTO tb_gestor VALUES ('13439545949', 'denis marques	', 'denis1914@gmail.com', tp_fones(tp_fone('11', '31', '212212222')));

-- FUNCIONARIOS

INSERT INTO tb_funcionario VALUES ('15141213987','Pedro Augusto','pedrinhojogador@outlook.com', tp_fones(tp_fone(55,83,978456160)), 'Recepcionista', 1800.0, '10-JAN-20', NULL);

INSERT INTO tb_funcionario VALUES ('47141913587','Karina Feitosa','karinaff@gmail.com', tp_fones(tp_fone(55,71,998153060)), 'Analista de Obras', 2500.0, TO_DATE('23-AUG-15', 'yyyy/mm/dd'), TO_DATE('12-FEB-21', 'yyyy/mm/dd') );

INSERT INTO tb_funcionario VALUES ('32052949538','Silvio Correia','scorreia@yahoo.com', tp_fones(tp_fone(55,83,978456160)), 'Zelador', 1600.0, TO_DATE('01-JUN-18', 'yyyy/mm/dd'), NULL);

INSERT INTO tb_funcionario VALUES ('15141213987','Natanael Rodrigues','nath15@gmail.com', tp_fones(tp_fone(55,73,998476470)), 'Vigia', 6000.0, '01-JUN-15', NULL);

-- HABITA N tem tabela

-- GERENCIA

INSERT INTO tb_gerencia VALUES ((SELECT REF(X) FROM tb_gestor X WHERE cpf = '54985978594'), (SELECT REF(Y) FROM tb_condominio Y WHERE codigo = 1),'54985978594', 1, 'Sindico', TO_DATE('15-OCT-01','yyyy/mm/dd'), NULL);

INSERT INTO tb_gerencia VALUES ((SELECT REF(X) FROM tb_gestor X WHERE cpf = '55468594785'), (SELECT REF(Y) FROM tb_condominio Y WHERE codigo = 1),'55468594785', 1, 'Contador', TO_DATE('25-OCT-01','yyyy/mm/dd'), NULL);

INSERT INTO tb_gerencia VALUES ((SELECT REF(X) FROM tb_gestor X WHERE cpf = '12345678910'), (SELECT REF(Y) FROM tb_condominio Y WHERE codigo = 2),'12345678910', 2, 'Sindico', TO_DATE('12-JUL-01','yyyy/mm/dd'), NULL);

INSERT INTO tb_gerencia VALUES ((SELECT REF(X) FROM tb_gestor X WHERE cpf = '13439545949'), (SELECT REF(Y) FROM tb_condominio Y WHERE codigo = 2),'13439545949', 2, 'Contador', TO_DATE('01-JAN-03','yyyy/mm/dd'), NULL);

-- TRABALHA

INSERT INTO tb_trabalha VALUES (tp_relac_trabalha((SELECT REF(X) FROM tb_funcionario X WHERE cpf = '15141213987' AND data_admissao = '10-JAN-20'), (SELECT REF(Y) FROM tb_condominio Y WHERE codigo = 1), '15141213987', TO_DATE('10-JAN-20','yyyy/mm/dd'), 1, TO_DATE('10-JAN-20','yyyy/mm/dd'), NULL));

INSERT INTO tb_trabalha VALUES(tp_relac_trabalha((SELECT REF(F) FROM tb_funcionario F WHERE cpf = '47141913587' AND data_admissao = TO_DATE('23-AUG-15', 'yyyy/mm/dd')), (SELECT REF(C) FROM tb_condominio C WHERE codigo = 2),  '47141913587', TO_DATE('23-AUG-15', 'yyyy/mm/dd'), 2, TO_DATE('23-AUG-15', 'yyyy/mm/dd'), NULL));

-- AVALIA

INSERT INTO tb_avalia VALUES('54985978594', '55468594785', (SELECT REF(X) FROM tb_gestor X WHERE cpf = '54985978594'), (SELECT REF(Y) FROM tb_gestor Y WHERE cpf = '55468594785'), TO_TIMESTAMP ( '10-Sep-20 14:00:10', 'DD-Mon-RR HH24:MI:SS' ), 'comprometida');

INSERT INTO tb_avalia VALUES('12345678910', '13439545949', (SELECT REF(X) FROM tb_gestor X WHERE cpf = '12345678910'), (SELECT REF(Y) FROM tb_gestor Y WHERE cpf = '13439545949'), TO_TIMESTAMP ( '09-Oct-20 14:00:00', 'DD-Mon-RR HH24:MI:SS' ), 'dedicado');

-- OCORRENCIA

INSERT INTO tb_ocorrencia VALUES ((SELECT REF(P) FROM tb_morador P WHERE cpf = '77777777777'), (SELECT REF(C) FROM tb_condominio C WHERE codigo = 2), NULL, 21, TO_TIMESTAMP ( '18-Sep-19 06:22:03', 'DD-Mon-RR HH24:MI:SS' ), 'Entrou um gato pela minha janela', NULL, NULL, NULL);

INSERT INTO tb_ocorrencia VALUES ((SELECT REF(P) FROM tb_morador P WHERE cpf = '22222222222'), (SELECT REF(C) FROM tb_condominio C WHERE codigo = 1), NULL, 25, TO_TIMESTAMP ( '08-Aug-18 22:06:47', 'DD-Mon-RR HH24:MI:SS' ), 'Roberto Carlos esta fazendo muito barulho e eu nao consigo dormir, falei com o Silvio e ele disse nao poder dazer nada', NULL, NULL, tp_pessoas(tp_pessoa_ref((SELECT REF(P) FROM tb_morador P WHERE cpf = '1111111111')), tp_pessoa_ref((SELECT REF(F) FROM tb_funcionario F WHERE cpf = '32052949538' AND data_admissao = '01-JUN-18'))));

-- RESERVA

INSERT INTO tb_reserva VALUES ('12345678999', 1, 'Salão de Festas', (SELECT REF(X) FROM tb_morador X WHERE cpf = '12345678999'), (SELECT REF(Y) FROM tb_espaco Y WHERE nome = 'Salão de Festas' AND codigo_cond = 1), (SELECT REF(Z) FROM tb_gestor Z WHERE cpf = '54985978594'), TO_TIMESTAMP ( '10-Sep-16 14:00:10', 'DD-Mon-RR HH24:MI:SS' ), 180); 

INSERT INTO tb_reserva VALUES ('22222222222', 2, 'Piscina', (SELECT REF(X) FROM tb_morador X WHERE cpf = '22222222222'), (SELECT REF(Y) FROM tb_espaco Y WHERE nome = 'Piscina' AND codigo_cond = 2), (SELECT REF(Z) FROM tb_gestor Z WHERE cpf = '12345678910'), TO_TIMESTAMP ( '20-Dec-13 08:00:10', 'DD-Mon-RR HH24:MI:SS' ), 120); 
