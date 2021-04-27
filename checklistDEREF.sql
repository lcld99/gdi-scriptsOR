-- REQUISITOS DA CHECKLIST ATENDIDOS NESSE ARQUIVO
-- 1. SELECT DEREF
SELECT M.nome AS dono, DEREF(T.apartamento).numero AS NUMERO, DEREF(T.apartamento).bloco AS BLOCO, DEREF(T.apartamento.cond).nome AS CONDOMINIO FROM tb_morador M, TABLE(M.casas) T WHERE T.proprietario = 1 ORDER BY M.pessoaTOnome();
