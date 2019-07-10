/*
 * Funcao que retorna o boletim completo de um aluno de uma turma de um determinado ano
 * Args:
 *      id_aluno: int
 *      id_turma: int
 *		ano_letivo: int
 * Return:
 *      Table( 
 *            nome_disciplina: varchar(255), 
 *            nota_1, nota_2, nota_3, nota_4, media_1, nota_5, nota_6, nota_7, nota_8, media_2, media_final: decimal(4,2)
 *       )
 */
CREATE OR REPLACE FUNCTION boletim_do_aluno(id_aluno INT, id_turma INT, ano_letivo INT) RETURNS
TABLE (descricao varchar(255),
        prova_1 decimal(4,2), prova_2 decimal(4,2), prova_3 decimal(4,2), prova_4 decimal(4,2), media_1 decimal(4,2),
        prova_5 decimal(4,2), prova_6 decimal(4,2), prova_7 decimal(4,2), prova_8 decimal(4,2), media_2 decimal(4,2), media_final decimal(4,2))
AS $$
DECLARE
    aula_iterator record;
    boletim_disc record;
BEGIN
	/* NAO EXISTE NENHUMA AULA PARA A TURMA SELECIONADA NO ANO SELECIONADO */
    IF NOT EXISTS (SELECT * FROM aula a WHERE a.id_turma = $2 AND a.ano_letivo = $3) THEN
		raise exception 'Turma nao existe ou nao cadatrada para o ano de %', ano_letivo;
	/* ALUNO NAO VINCULADO A TURMA SELECIONADA */
	ELSIF NOT EXISTS (SELECT * FROM aluno_turma a WHERE a.id_aluno = $1 AND a.id_turma = $2) THEN
		raise exception 'Aluno não é matriculado na turma';
	END IF;
 
    DROP TABLE IF EXISTS tmp_boletim_do_aluno;
    CREATE TEMP TABLE tmp_boletim_do_aluno
		(id_tp_boletim_do_aluno serial, descricao varchar(255),
		prova_1 decimal(4,2), prova_2 decimal(4,2), prova_3 decimal(4,2), prova_4 decimal(4,2), media_1 decimal(4,2),
		prova_5 decimal(4,2), prova_6 decimal(4,2), prova_7 decimal(4,2), prova_8 decimal(4,2), media_2 decimal(4,2), media_final decimal(4,2));
 
    FOR aula_iterator IN (SELECT * FROM aula a WHERE a.id_turma = $2 AND a.ano_letivo = $3) LOOP
        SELECT * INTO boletim_disc FROM boletim_da_disciplina($1, aula_iterator.id_aula);
        INSERT INTO tmp_boletim_do_aluno VALUES
            (DEFAULT, boletim_disc.descricao, boletim_disc.prova_1, boletim_disc.prova_2, boletim_disc.prova_3,boletim_disc.prova_4, boletim_disc.media_1,
            boletim_disc.prova_5,  boletim_disc.prova_6, boletim_disc.prova_7, boletim_disc.prova_8, boletim_disc.media_2, boletim_disc.media_final);
    END LOOP;
 
    RETURN query SELECT
		/* TABLE PARA RETURNO FORMATADA CO*/
        t.descricao, t.prova_1, t.prova_2, t.prova_3, t.prova_4, t.media_1, 
		t.prova_5,  t.prova_6, t.prova_7, t.prova_8, t.media_2, t.media_final
        FROM tmp_boletim_do_aluno t order by t.descricao;
END;
$$ LANGUAGE plpgsql;
