create or replace function alunos_da_turma(id_turma_procudara int, year int) 
	returns table (
		id_aluno int,
		matricula_aluno varchar,
		nome_aluno varchar,
		nascimento_aluno date,
		data_matricula date
	)
as $$

begin
	return query select a.id_aluno, a.matricula_aluno, a.nome_aluno, a.nascimento_aluno, at.data from
		aluno a natural join aluno_turma at where extract(year from data) = year order by a.nome_aluno;

end; 
$$ language plpgsql;

select * from alunos_da_turma(3, 2019);

