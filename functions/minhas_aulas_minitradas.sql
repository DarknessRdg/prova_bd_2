/*
 * Funcao que retorna dados das aulas que o professor logado ministra
 * 		return table (
 *	 		materia, turma, turno, escola
 *		)
 */
create or replace function minhas_aulas_minitradas() returns table (materia varchar(255), turma text, turno char(5), escola varchar(255)) as $$
begin
	return query select d.descricao materia, t.ano || 'º ' ||  t.sigla turma, t.turno, e.nome escola
		from professor  natural join aula natural join disciplina d natural join turma t natural join escola e where 
		matricula_professor = current_user;
end;
$$ language plpgsql;