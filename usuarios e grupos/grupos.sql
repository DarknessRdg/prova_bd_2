create group diretor;
create group professor;
create group aluno;

revoke all on schema public from public  -- tira todos privilegios de todas tabelas / funcoes
grant all on aluno, aluno_turma, turma, professor, escola, disciplina, aula, aplicacao, prova, questao, gabarito, alternativa, resposta 
    to group diretor; -- garante todos direitos ao diretor
grant select, insert, update, delete on aplicacao, prova, questao, alternativa, gabarito to group professor;
grant insert on resposta to group aluno;

aluno, aluno_turma, turma, professor, escola, disciplina, aula, aplicacao, prova, questao, gabarito, alternativa, resposta