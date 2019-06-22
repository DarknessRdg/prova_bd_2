-- TRIGGER NA TABELA ALUNO_TURMA
-- DESCRICAO:
--     * UM ALUNO SO PODE SER MATRICULADO (VINCULADO A TABELA)
--       UMA VEZ POR ANO;


CREATE FUNCTION validate_aluno_turma() RETURNS TRIGGER AS $$
BEGIN
    IF EXTRACT(YEAR FROM NEW.DATA) IN
    (SELECT EXTRACT(YEAR FROM DATA) FROM aluno_turma WHERE NEW.id_aluno = id_aluno) THEN
        IF TG_OP = 'UPDATE' THEN
            IF EXTRACT(YEAR FROM NEW.DATA) = EXTRACT(YEAR FROM OLD.DATA) THEN
                RETURN NEW;
            END IF;
        END IF;
       
        raise exception 'um aluno so pode ser matriculado uma vez por ano';
    END IF;
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 

CREATE TRIGGER verifiar_aluno_turma BEFORE INSERT OR UPDATE ON aluno_turma
    FOR EACH ROW EXECUTE PROCEDURE validate_aluno_turma();