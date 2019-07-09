create or replace function criar_diretor(usuario varchar, senha varchar) returns void as $$
begin
	EXECUTE FORMAT('CREATE USER "%s" LOGIN PASSWORD ''%s'' IN GROUP diretor', usuario, senha);
end;
$$ language plpgsql;