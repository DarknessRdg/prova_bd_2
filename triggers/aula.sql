-- TRIGGER NA TABELA AULA
-- DESCRICAO:
--     * A DISCIPLINA E A TURMA A SEREM VINCULADAS DEVEM 
--       POSSUIR MESMO VALOR PARA `ANO`;

--     * A DISCIPLINA E A TURMA A SEREM VINCULADAS DEVEM 
--       POSSUIR MESMO VALOR PARA `E_MEDIO`;


CREATE OR REPLACE FUNCTION validate_aula() RETURNS TRIGGER AS $$
DECLARE
    ano_turma INT;
    ano_disciplina INT;
    e_medio_turma BOOLEAN;
    e_medio_disciplina BOOLEAN;
BEGIN
    SELECT ano, e_medio INTO ano_turma, e_medio_turma FROM turma WHERE id_turma = NEW.id_turma;
    SELECT ano, e_medio INTO ano_disciplina, e_medio_disciplina FROM disciplina WHERE id_disciplina = NEW.id_disciplina;
 
    IF ano_turma != ano_disciplina THEN
        raise exception 'Ano da disciplina tem que ser igual ao da turma.';
    ELSIF e_medio_disciplina != e_medio_turma THEN
        raise exception 'Grau (medio / fundamental) da disciplina tem que ser igual ao da turma.';
    ELSIF EXISTS (SELECT * FROM aula WHERE 
            id_turma = new.id_turma and id_professor = new.id_professor and id_disciplina = new.id_disciplina and 
            ano_letivo = new.ano_letivo
        ) then
        raise exception 'Aula já cirada.';
    END IF;

    RETURN NEW;
 
END;
$$ LANGUAGE plpgsql;
 
 
CREATE TRIGGER verificar_aula BEFORE INSERT OR UPDATE ON aula
    FOR EACH ROW EXECUTE PROCEDURE validate_aula();
