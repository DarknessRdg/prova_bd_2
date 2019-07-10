/* 
 * return dados do usuario - aluno / professor 
 */
create or replace function meus_dados() returns table (nome varchar(255), nascimento date, matricula varchar(255)) as $$
begin	
	if exists (select * from aluno where matricula_aluno = current_user) then
		return query select nome_aluno, nascimento_aluno, matricula_aluno from aluno where matricula_aluno = current_user;
	elsif exists (select * from professor where matricula_professor = current_user) then
		return query select nome_professor, nascimento_professor, matricula_professor from professor where matricula_professor = current_user;
	end if;
end;
$$ language plpgsql;


