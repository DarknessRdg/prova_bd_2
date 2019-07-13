create or replace function ativar_professor(id_professor int) returns void as $$
declare
	matricula varchar(10) := (select matricula_professor from professor p where p.id_professor = $1);
begin
	EXECUTE FORMAT('CREATE USER "%s" LOGIN PASSWORD ''%s'' IN GROUP professor', matricula, matricula);
end;
$$ language plpgsql;