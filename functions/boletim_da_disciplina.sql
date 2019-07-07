/*
 * Funcao que retorna o notas do aluno(estilo boletim) de um aluno de uma unica disciplina
 * Args:
 *      id_aluno: int
 *      id_aula: int
 * Return:
 *      Table( 
 *            nome_disciplina: varchar(255), 
 *            nota_1, nota_2, nota_3, nota_4, media_1, nota_5, nota_6, nota_7, nota_8, media_2, media_final: decimal(4,2)
 *       )
 */
CREATE OR REPLACE FUNCTION boletim_da_disciplina(id_aluno INT, id_aula INT) RETURNS
    TABLE  (descricao varchar(255),
        prova_1 decimal(4,2), prova_2 decimal(4,2), prova_3 decimal(4,2), prova_4 decimal(4,2), media_1 decimal(4,2),
        prova_5 decimal(4,2), prova_6 decimal(4,2), prova_7 decimal(4,2), prova_8 decimal(4,2), media_2 decimal(4,2), media_final decimal(4,2))
AS $$
DECLARE
    notas decimal(4,2) ARRAY[8];
    descricao varchar(255);
    aplicacao record;
    indice INT := 1;
    media_1 decimal(4,2);
    media_2 decimal(4,2);
BEGIN
    FOR aplicacao IN (SELECT id_aplicacao, d.descricao FROM disciplina d NATURAL JOIN aplicacao NATURAL JOIN aula a WHERE a.id_aula = $2) LOOP
        notas[indice] := nota_do_aluno(id_aluno, aplicacao.id_aplicacao);
        descricao := aplicacao.descricao;
        indice := indice + 1;
    END LOOP;
    
    media_1 := (notas[1] + notas[2] + notas[3] + notas[4]) / 4.0;
    media_2 := (notas[5] + notas[6] + notas[7] + notas[8]) / 4.0;
    RETURN query SELECT descricao,
                        notas[1], notas[2], notas[3], notas[4], media_1,
                        notas[5], notas[6], notas[7], notas[8], media_2, (media_1 + media_2) / 2.0;
END;
$$ LANGUAGE plpgsql;
