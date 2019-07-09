/*
 * Inserir usuario do tipo professor 
 */
create or replace function inserir_professor() returns trigger as $$
begin
	EXECUTE FORMAT('CREATE ROLE "%s" LOGIN PASSWORD ''%s'' IN GROUP professor', new.matricula_professor, new.matricula_professor);
	return new;
end;
$$ language plpgsql;

CREATE TRIGGER insert_in_professor BEFORE INSERT ON professor
    FOR EACH ROW EXECUTE PROCEDURE inserir_professor();