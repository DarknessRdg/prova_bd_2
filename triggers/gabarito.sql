-- TRIGGER NA TABELA GABARITO
-- DESCRICAO:
--     1 A QUESTAO VINCULADA AO GABARITO TEM QUE TER DISCIPLINA DA PROVA 
--     2 MAXIMO DE 5 ALTERNATIVAS POR QUESTAO
--     3 MAXIMO DE 10 QUESTOES POR PROVA
--     4 EXISTE SOMENTE 1 RESPOTA CERTA POR QUESTAO POR PROVA
--     5 NAO PERMITIR ALTERNATIVAS IGUAIS NA MESMA QUESTAO 
--     6 BLOQUEAR UPDATE DE MUDANÇA DE UM GABARITO ENTRE PROVAS E ENTRE QUESTÕES
--     7 TORNAR QUESTOES E PROVAS COMPLETAS QUANDO NECESSÁRIO COMO TAMBEM REVERTER ESSE ESTADO
 
CREATE OR REPLACE FUNCTION validate_gabarito() RETURNS TRIGGER AS $$
DECLARE
    prova record;
    questao record;
	quantidade_de_alternativas int;
	quantidade_de_questoes int;
BEGIN
    SELECT * INTO questao FROM questao WHERE id_questao = NEW.id_questao;
    SELECT * INTO prova FROM prova WHERE id_prova = NEW.id_prova;
	SELECT count(*) INTO quantidade_de_alternativas from gabarito where id_prova = NEW.id_prova and id_questao = NEW.id_questao and gabarito_ativo = true ;
	SELECT count(*) INTO quantidade_de_questoes from (SELECT count(*) from gabarito where id_prova = NEW.id_prova GROUP BY id_questao) AB;
    
	-- CONDICAO 1
	IF  questao.id_disciplina != prova.id_disciplina THEN
        raise exception 'A disciplina da prova deve ser igual a disciplina da questao.';
	END IF;
    
	
	-- CONDICAO 2
	IF quantidade_de_alternativas = 5 THEN
		IF TG_OP = 'UPDATE' THEN 
			IF OLD.id_questao = NEW.id_questao AND OLD.e_certo = NEW.e_certo THEN
				RETURN NEW;
			END IF;
		-- PARCIAL CONDICAO	4
		raise exception 'somente e/ou pelo menos 1 alternativa certa por questão.';
		END IF;
		IF TG_OP = 'INSERT' THEN 
			raise exception 'limite maximo de 5 alternativas por questões ja atendido.';
		END IF;
	END IF;
	
	-- CONDICAO 3
	IF  quantidade_de_questoes = 10 and quantidade_de_alternativas = 0 THEN 
		raise exception 'limite maximo de 10 questões por prova ja atendido.';
	END IF;
		
	-- CONDICAO 4
	IF true in (SELECT e_certo FROM gabarito where id_prova = NEW.id_prova and id_questao = NEW.id_questao and gabarito_ativo = true )THEN
		IF NEW.e_certo = true THEN
			raise exception 'somente uma alternativa certa por questão';
		END IF;
	ELSIF quantidade_de_alternativas = 4 AND NEW.e_certo = false THEN
		raise exception 'pelo menos 1 alternativa deve ser verdadeira';
	END IF;
		
	-- CONDICAO 5
	IF NEW.id_alternativa in (SELECT id_alternativa from gabarito where id_prova = NEW.id_prova and id_questao = NEW.id_questao and gabarito_ativo = true ) THEN 
		if (new.gabarito_ativo) then
			raise exception 'não é possivel colocar a mesma alternativa em uma questão';
		end if;
	END IF;

	-- CONDICAO 6 
	IF TG_OP = 'UPDATE' AND (NEW.id_questao != OLD.id_questao OR NEW.id_prova != OLD.id_prova) THEN
		raise exception 'impossivel mover uma alternativa entre questões ou uma questão entre provas';
	END IF;


	-- CONDICAO 7
	
 	IF quantidade_de_alternativas = 4 AND TG_OP = 'INSERT'  THEN
 		update questao set finalizada = true where id_questao = NEW.id_questao ;
	END IF;
	IF (SELECT count(*) from gabarito where id_prova = NEW.id_prova) = 49 AND TG_OP = 'INSERT'  THEN
		update prova set finalizada = true where id_prova = NEW.id_prova ;
	END IF;
	
   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

 
 
CREATE TRIGGER verificar_gabarito BEFORE INSERT OR UPDATE ON gabarito
    FOR EACH ROW EXECUTE PROCEDURE validate_gabarito();
	
	
	
 
CREATE OR REPLACE FUNCTION on_delete_gabarito() RETURNS TRIGGER AS $$
BEGIN
	update questao set finalizada = false where id_questao = old.id_questao;
	update prova set finalizada = false where id_prova = old.id_prova;
   	return old;
    
END;
$$ LANGUAGE plpgsql;
 
 
CREATE TRIGGER on_delete_gabarito BEFORE DELETE ON gabarito
    FOR EACH ROW EXECUTE PROCEDURE on_delete_gabarito();
	



	
	
