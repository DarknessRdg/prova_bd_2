CREATE OR REPLACE FUNCTION meu_boletim()
  RETURNS TABLE(descricao character varying, prova_1 numeric, prova_2 numeric, prova_3 numeric, prova_4 numeric, media_1 numeric, prova_5 numeric, prova_6 numeric, prova_7 numeric, prova_8 numeric, media_2 numeric, media_final numeric) AS
$$
declare 
	meu_id int; 
	minha_turma int; 
begin
	select id_aluno, id_turma into meu_id, minha_turma from aluno natural join aluno_turma 
		where matricula_aluno = current_user and extract(year from data) = extract(year from now());
	
	return query select * from boletim_do_aluno(meu_id, minha_turma, cast(extract(year from now()) as int));

end;
$$
  LANGUAGE plpgsql;