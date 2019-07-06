-- TRIGGER NA TABELA RESPOSTA
-- DESCRICAO:
--     * SOMENTE 1 RESPOSTA POR ALUNO POR QUESTAO POR PROVA
--     * ALUNO MATRICULADO NA MESMA TURMA DA APLICACAO


CREATE OR REPLACE FUNCTION validate_resposta() RETURNS TRIGGER AS $$
DECLARE
    gabarito_new record;
	aplicacao_new record;
	aula_new record;
    diferenca INT;
BEGIN
    SELECT * INTO gabarito_new FROM gabarito WHERE id_gabarito = NEW.id_gabarito;
	SELECT * INTO aplicacao_new FROM aplicacao WHERE id_aplicacao = NEW.id_aplicacao;
	SELECT * INTO aula_new from aula where id_aula = aplicacao_new.id_aula;
	
    if gabarito_new.id_questao in (Select distinct id_questao FROM gabarito 
	WHERE id_gabarito in (select id_gabarito from resposta where id_aluno  = new.id_aluno)and id_prova = gabarito_new.id_prova) then
   		raise exception 'essa questão já foi respondida pelo aluno ';
	end if;
	
	if new.id_aluno not in (select id_aluno from aluno_turma where id_turma = aula_new.id_turma and extract(year from aluno_turma.data) = aula_new.ano_letivo) then
		raise exception 'esse aluno não esta matriculado na turma da aplicaçõa dessa prova';
   	end if;
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



 
 
CREATE TRIGGER verificar_resposta BEFORE INSERT OR UPDATE ON resposta
    FOR EACH ROW EXECUTE PROCEDURE validate_resposta();
	


