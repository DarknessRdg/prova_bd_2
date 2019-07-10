create group diretor;
create group professor;
create group aluno;

grant usage on schema public to group aluno;
grant usage on schema public to group professor;

-- diretor
grant all on schema public to group diretor;
grant all on aluno, aluno_turma, turma, professor, escola, disciplina, aula, aplicacao, prova, questao, gabarito, alternativa, resposta 
    to group diretor; -- garante todos direitos ao diretor

-- professor
grant select on table aluno to group professor  -- meus_dados()
grant select, insert, update, delete on aplicacao, prova, questao, alternativa, gabarito to group professor;
grant select on escola, aula, turma, disciplina, professor to group professor;

-- aluno
grant insert on resposta to group aluno;
grant select on aluno, aluno_turma, turma, disciplina, aula, aplicacao, prova, questao, gabarito, alternativa, resposta to aluno
grant execute on function meu_boletim, meus_dados to aluno;

aluno, aluno_turma, turma, professor, escola, disciplina, aula, aplicacao, prova, questao, gabarito, alternativa, resposta