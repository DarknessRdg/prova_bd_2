-- TRIGGER NA TABELA RESPOSTA
-- DESCRICAO:
--     * SOMENTE 1 RESPOSTA POR ALUNO POR QUESTAO POR PROVA
--     * ALUNO MATRICULADO NA MESMA TURMA DA APLICACAO

 
CREATE OR REPLACE FUNCTION validate_resposta() RETURNS TRIGGER AS $$
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
	ELSIF prova.finalizada = false THEN
		raise exception 'Não é possivel cadastrar aplicações com provas não finalizadas';
    END IF;
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
 
CREATE TRIGGER verificar_resposta BEFORE INSERT OR UPDATE ON resposta
    FOR EACH ROW EXECUTE PROCEDURE validate_resposta();