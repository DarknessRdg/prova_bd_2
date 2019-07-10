/*
 * Funcao que retorna gabarito completo da prova ordenado por id_questao, id_gabarito
 * Args:
 *      prova: int represanto id da prova
 * Return:
 *      table com gabarito da prova:
 *          (id_gabarito int,
 *          id_prova int,
 *          id_questao int,
 *          id_alternativa int,
 *          e_certo)
 */
CREATE OR REPLACE FUNCTION gabarito_da_prova(prova INT) RETURNS
    table(
        id_gabarito INT,
        id_prova INT,
        id_questao INT,
        id_alternativa INT,
        e_certo BOOLEAN
    )
AS $$
BEGIN
    RETURN query SELECT g.id_gabarito, g.id_prova, g.id_questao, g.id_alternativa, g.e_certo 
        FROM gabarito g WHERE g.id_prova = prova ORDER BY g.id_questao, g.id_gabarito;
END;
$$ LANGUAGE plpgsql;