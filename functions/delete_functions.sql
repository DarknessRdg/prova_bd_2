create or replace function deletar_aluno(pk int) returns void as  $$
declare
	matricula varchar(10) := (select matricula_aluno from aluno where id_aluno = pk);
begin
	update aluno set aluno_ativo = false where id_aluno = pk;
	EXECUTE FORMAT('DROP USER "%s"', matricula);
end;
$$ language plpgsql;


create or replace function desvincular_aluno_a_turma(pk int) returns void as  $$
begin
	update  aluno_turma set aluno_turma_ativo = false where id_aluno_turma = pk;
end;
$$ language plpgsql;


create or replace function deletar_turma(pk int) returns void as $$
begin
	update turma set turma_ativo = false where id_turma = pk;
end;
$$ language plpgsql;


create or replace function deletar_professor(pk int) returns void as $$
declare
	matricula varchar(10) := (select matricula_professor from professor where id_professor = pk);
begin
	update professor set professor_ativo = false where id_professor = pk;
	EXECUTE FORMAT('DROP USER "%s"', matricula);
end;
$$ language plpgsql ;

create or replace function deletar_disciplina(pk int) returns void as  $$
begin
	update  disciplina set disciplina_ativo = false where id_disciplina = pk;
end;
$$ language plpgsql;


create or replace function deletar_aula(pk int) returns void as $$
begin
	update aula set aula_ativo = false where id_aula = pk;
end;
$$ language plpgsql;


create or replace function deletar_escola(pk int) returns void as  $$
begin
	delete from escola where id_escola = pk;
end;
$$ language plpgsql;


create or replace function deletar_aplicacao(pk int) returns void as  $$
begin
	update aplicacao set aplicacao_ativo = false where id_aplicacao = pk;
end;
$$ language plpgsql;


create or replace function deletar_prova(pk int) returns void as  $$
begin
	update prova set prova_ativo = false where id_prova = pk;
end;
$$ language plpgsql;


create or replace function deletar_questao(pk int) returns void as  $$
begin
	update questao set questao_ativo = false where id_questao = pk;
end;
$$ language plpgsql;


create or replace function deletar_gabarito(pk int) returns void as  $$
begin
	update gabarito set gabarito_ativo = false where id_gabarito = pk;
end;
$$ language plpgsql;


create or replace function deletar_alternativa(pk int) returns void as  $$
begin
	update alternativa set alternativa_ativo = false where id_alternativa = pk;
end;
$$ language plpgsql;


create or replace function deletar_resposta(pk int) returns void as  $$
begin
	delete from resposta where id_resposta = pk;
end;
$$ language plpgsql;
