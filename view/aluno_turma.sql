create or replace view view_aluno_turma as 
    select id_aluno, nome_aluno, matricula_aluno, data, turmas_ativas.* 
        from  alunos_ativos natural join aluno_turmas_ativas natural join turmas_ativas;