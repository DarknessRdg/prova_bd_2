create or replace function criar_aluno(b varchar(255), c date, d char(5)) returns void as  $$
declare 
	pk int := (select max(id_aluno) + 1 from aluno);
begin
	insert into aluno(id_aluno, nome_aluno, nascimento_aluno, matricula_aluno) values (pk, $1, $2, $3);
end;
$$ language plpgsql;


create or replace function vincular_aluno_a_turma(a int, b int) returns void as  $$
declare 
	pk int := (select max(id_aluno_turma) + 1 from aluno_turma);
begin
	if (select aluno_ativo from aluno where id_aluno = a) and (select turma_ativo from turma where id_turma = b) then
		insert into aluno_turma(id_aluno_turma, id_aluno, id_turma, data) values (pk, $1, $2, now());
	else
		raise exception 'Aluno ou turma nao existe';
	end if;
end;
$$ language plpgsql;


create or replace function criar_turma(a char(1), b int, c boolean, d char(5), e int) returns void as $$
declare 
	pk int := (select max(id_turma) + 1 from turma);
begin
	insert into turma(id_turma, ano, sigla, turno, e_medio, id_escola) values (pk, b, a, d, c, e);
end;
$$ language plpgsql;


create or replace function criar_professor(n varchar(255), nasc date, matricula varchar(10), cpf_ char(11)) returns void as $$
declare 
	pk int := (select max(id_professor) + 1 from professor);
begin
	insert into professor(id_professor, nome_professor, nascimento_professor, cpf, matricula_professor) values
	(pk, n, nasc, cpf_, matricula);
end;
$$ language plpgsql ;

create or replace function criar_disciplina(d varchar(255), ano int,medio boolean) returns void as $$
declare 
	pk int := (select max(id_disciplina) + 1 from disciplina);
begin
	insert into disciplina(id_disciplina, descricao, ano, e_medio) values
	(pk, d,ano,medio);
end;
$$ language plpgsql ;



create or replace function criar_aula(t int, d int, p int, a int) returns void as $$
declare 
	pk int := (select max(id_aula) + 1 from aula);
begin
	if (select professor_ativo from professor where id_professor = p) and 
	   (select disciplina_ativo from disciplina where id_disciplina = d) and
	   (select turma_ativo from turma where id_turma = t) then 
		insert into aula(id_aula, id_turma, id_professor, id_disciplina, ano_letivo) values
		(pk, t, p, d, a);
	else
		raise exception 'Professor ou turma ou disciplina nao existem';
	end if;
end;
$$ language plpgsql;


create or replace function criar_escola(nome_ varchar(255), n int, comp varchar(255), cep_ varchar(8)) returns void as  $$
declare 
	pk int := (select max(id_escola) + 1 from escola);
begin
	insert into escola(id_escola, nome, cep, numero, complemento)  values
	(pk, nome_, cep_, n, comp);
end;
$$ language plpgsql;


create or replace function criar_aplicacao(a int, p int, data date) returns void as  $$
declare 
	pk int := (select max(id_aplicacao) + 1 from aplicacao);
begin
	if (select aula_ativo from aula where id_aula = a) and (select prova_ativo from prova where id_prova = p) then	
		insert into aplicacao(id_aplicacao, id_aula, id_prova, data_aplicacao) values 
		(pk, a, p, data);
	else
		raise exception 'Prova ou aula nao existem';
	end if;
end;
$$ language plpgsql;


create or replace function criar_prova(d int) returns void as  $$
declare 
	pk int := (select max(id_prova) + 1 from prova);
begin
	if (select disciplina_ativo from disciplina where id_disciplina = d) then
		insert into prova(id_prova, id_disciplina, finalizada)  values
		(pk, d, false);
	else
		raise exception 'Disciplina nao existe';
	end if;
end;
$$ language plpgsql;


create or replace function criar_questao(e varchar(500), disc int) returns void as  $$
declare 
	pk int := (select max(id_questao) + 1 from questao);
begin
	if (select disciplina_ativo from disciplina where id_disciplina = disc) then
		insert into questao(id_questao, enunciado, id_disciplina, finalizada) values 
		(pk,e, disc, false);
	else
		raise exception 'Disciplina nao existe';
	end if;
end;
$$ language plpgsql;


CREATE OR REPLACE FUNCTION public.criar_gabarito(p integer,q integer,a integer,bool boolean)
  RETURNS void AS $$
declare 
	pk int := (select max(id_gabarito) + 1 from gabarito);
begin
	if (select prova_ativo from prova where id_prova = p) and 
	   (select questao_ativo from questao where id_questao = q) and
	   (select alternativa_ativo from alternativa where id_alternativa = a) then	
		insert into gabarito(id_gabarito, id_prova, id_questao, id_alternativa, e_certo) values 
		(pk, p, q, a, bool);
	else
		raise exception 'Prova ou questao ou alternativa nao existem';
	end if;
end;
$$ LANGUAGE plpgsql;


create or replace function criar_alternativa(c varchar(255)) returns void as  $$
declare 
	pk int := (select max(id_alternativa) + 1 from alternativa);
begin
	insert into alternativa(id_alternativa, descricao) values 
	(pk, c);
end;
$$ language plpgsql;



create or replace function criar_resposta(a int, ap int, g int) returns void as  $$
declare 
	pk int := (select max(id_resposta) + 1 from resposta);
begin
	if (select aplicacao_ativo from aplicacao where id_aplicacao = ap) and 
	   (select gabarito_ativo from gabarito where id_gabarito= g) and
	   (select aluno_ativo from aluno where id_aluno = a) then	
			INSERT INTO resposta(id_resposta, id_aluno, id_aplicacao, id_gabarito) VALUES
			(pk, a, ap, g);
	else 
		raise exception 'aluno ou gabarito ou aplicacao não existe';
	end if;
end;
$$ language plpgsq