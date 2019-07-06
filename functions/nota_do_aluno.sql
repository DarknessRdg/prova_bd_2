/*
 * Funcao que retorna a nota do aluno em uma determinada avaliacao
 * Args:
 *    id_aluno: int
 *    id_avaliavao: int
 * Returns:
 *    int: nota do aluno na aplicaco
 */
CREATE OR REPLACE FUNCTION nota_do_aluno(id_aluno INT, id_avaliacao INT) RETURNS FLOAT AS $$
DECLARE
    prova INT;
    qnt_questoes INT;
BEGIN
    SELECT a.id_prova INTO prova FROM aplicacao a WHERE a.id_aplicacao = $2;
    SELECT COUNT(*) INTO qnt_questoes FROM (SELECT id_questao FROM gabarito_da_prova(prova) GROUP BY id_questao) r;
 
    IF qnt_questoes = 0 THEN /* divion by zero */
        RETURN 0;
    END IF;
   
    RETURN count_questoes_certas($1, $2) / cast(qnt_questoes AS FLOAT) * 10;
END;
$$ LANGUAGE plpgsql;