-- TRIGGER NA TABELA APLICACAO
-- DESCRICAO:
--     * A PROVA VINCULADA A APLICACAO TEM QUE TER DISCIPLINA DA AULA VINCULADA
--     * A APLICACAO SO PODE SER REPETIDA PARA A MESMA AULA A CADA 3 ANOS
--     * DATA DA APLICACAO TEM QUE SER DO MESMO ANO_LETIVO DA AULA

 
CREATE OR REPLACE FUNCTION validate_aplicacao() RETURNS TRIGGER AS $$
DECLARE
    prova record;
    aula record;
    diferenca INT;
BEGIN
    SELECT * INTO aula FROM aula WHERE id_aula = NEW.id_aula;
    SELECT * INTO prova FROM prova WHERE id_prova = NEW.id_prova;
    SELECT EXTRACT(YEAR FROM NEW.data_aplicacao) - EXTRACT(YEAR FROM MAX(data_aplicacao)) dif INTO diferenca
        FROM aplicacao WHERE id_aula = NEW.id_aula AND id_prova = NEW.id_prova;
 
    IF  aula.id_disciplina != prova.id_disciplina THEN
        raise exception 'A disciplina da prova deve ser igual a disciplina da aula.';
    ELSIF diferenca <  3 THEN
        raise exception 'A prova so pode ser repetida para a mesma turma a cada 3 anos.';
    ELSIF EXTRACT(YEAR FROM NEW.data_aplicacao) < aula.ano_letivo THEN
        raise exception 'Nao é possivel cadastrar aplicacoes para aulas de anos anteriores.';
    ELSIF EXTRACT(YEAR FROM NEW.data_aplicacao) > aula.ano_letivo THEN 
        raise exception 'Nao é possivel cadastrar aplicacoes para aulas de anos futuros.';
    END IF;
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
 
CREATE TRIGGER verificar_aplicacao BEFORE INSERT OR UPDATE ON aplicacao
    FOR EACH ROW EXECUTE PROCEDURE validate_aplicacao();