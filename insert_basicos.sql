-- ALUNO
insert into aluno(id_aluno, nome_aluno, nascimento_aluno, matricula_aluno) values
(1, 'jose pereira silva', '2000-12-10', '1234aluno'),
(2, 'geovana garcia soares', '2005-4-1', '4412aluno'),
(3, 'larissa santana rodigues de pinheiro', '1999-7-25', '31321aluno'),
(4, 'arthur de clara farias neto', '2004-1-6', '09521aluno'),
(5, 'pedro andadra borges', '1998-3-15', '09841aluno');


-- ESCOLA
insert into escola(id_escola, nome, cep, numero, complemento)  values
(1, 'ifpi', '65583140', 14, null),
(2, 'objetivo', '6432101', 3911, 'avenida frei serafim'),
(3, 'cev', '06542141', 1110, null);


-- TURMA
insert into turma(id_turma, ano, sigla, turno, e_medio, id_escola) values 
(1, 1, 'A', 'manha', false, 2),
(2, 1, 'B', 'manha', false, 2),
(3, 2, 'A', 'tarde', true, 2),
(4, 1, 'A', 'manha', true, 1),
(5, 1, 'B', 'manha', true, 1),
(6, 1, 'A', 'tarde', true, 1),
(7, 8, 'A', 'manha', false, 3),
(8, 8, 'B', 'manha', false, 3);


-- DISCIPLINA
insert into disciplina(id_disciplina, descricao, ano, e_medio) values
(1, 'matematica', 1, true),
(2, 'matematica', 1, false),
(3, 'matematica', 2, true),
(4, 'matematica', 2, false),
(6, 'matematica', 8, false),
(8, 'portugues', 1, true),
(9, 'portugues', 1, false),
(10, 'portugues', 2, true),
(11, 'portugues', 2, false),
(12, 'portugues', 8, false),
(13, 'fisica', 1, true),
(14, 'fisica', 1, false),
(15, 'fisica', 2, true),
(16, 'fisica', 2, false),
(17, 'fisica', 8, false);


-- PROFESSOR
insert into professor(id_professor, nome_professor, nascimento_professor, cpf, matricula_professor) values
(1, 'diego barros carvalho dias', '1994-10-1', '31291019191', '123prof'),
(2, 'daniel ferreira goncalves', '1989-4-20', '221321491', '3312prof'),
(3, 'andre marques martins', '1986-3-18', '0951543', '45180prof'),
(5, 'ana livia goncalves pinheiro', '1992-2-9', '599010421', '581prof'),
(6, 'helena melo oliveira', '1990-4-15', '9410141', '09861prof');

