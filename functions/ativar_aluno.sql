create or replace function ativar_aluno(id_aluno int) returns void as $$
declare
	matricula varchar(10) := (select matricula_aluno from aluno a where a.id_aluno = $1);
begin
	EXECUTE FORMAT('CREATE USER "%s" LOGIN PASSWORD ''%s'' IN GROUP ALUNO', matricula, matricula);
end;
$$ language plpgsql;