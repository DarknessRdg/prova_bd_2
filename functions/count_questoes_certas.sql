/*
 * Funcao que retorna a quantidade de questoes certas de um aluno em uma aplicacao
 * Args:
 *    id_aluno: Int
 *    id_aplicacao: Int
 * Return:
 *    int: representa quantidade de questoes certas do aluno na aplicacao
 */
CREATE OR REPLACE FUNCTION count_questoes_certas(id_aluno INT, id_aplicacao INT) RETURNS INT AS $$
BEGIN
    RETURN COUNT(*) FROM gabarito g NATURAL JOIN resposta r WHERE r.id_aluno = $1 AND r.id_aplicacao = $2 AND g.e_certo = TRUE;
END;
$$ LANGUAGE plpgsql;