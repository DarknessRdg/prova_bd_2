/*
 * Inserir usuario do tipo aluno 
 */
create or replace function inserir_aluno() returns trigger as $$
begin
	EXECUTE FORMAT('CREATE USER "%s" LOGIN PASSWORD ''%s'' IN GROUP ALUNO', new.matricula_aluno, new.matricula_aluno);
	return new;
end;
$$ language plpgsql;

CREATE TRIGGER insert_in_aluno BEFORE INSERT ON aluno
    FOR EACH ROW EXECUTE PROCEDURE inserir_aluno();


create or replace function deletar_user_aluno() returns trigger as $$
begin
	EXECUTE FORMAT('DROP USER "%s"', old.matricula_aluno);
	return old;
end;
$$ language plpgsql;

CREATE TRIGGER delete_aluno BEFORE DELETE ON aluno
    FOR EACH ROW EXECUTE PROCEDURE deletar_user_aluno();