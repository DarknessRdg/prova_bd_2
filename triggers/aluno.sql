/*
 * Inserir usuario do tipo aluno 
 */
create or replace function inserir_aluno() returns trigger as $$
begin
	EXECUTE FORMAT('CREATE ROLE "%s" LOGIN PASSWORD ''%s'' IN GROUP ALUNO', new.matricula_aluno, new.matricula_aluno);
	return new;
end;
$$ language plpgsql;

CREATE TRIGGER insert_in_aluno BEFORE INSERT ON aluno
    FOR EACH ROW EXECUTE PROCEDURE inserir_aluno();