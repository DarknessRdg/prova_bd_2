truncate aula cascade;
truncate aluno cascade;
truncate aluno_turma cascade;
truncate turma cascade;
truncate disciplina cascade;
truncate professor cascade;
truncate aplicacao cascade;
truncate prova cascade;
truncate questao cascade;
truncate alternativa cascade;
truncate gabarito cascade;
truncate resposta cascade;
truncate escola cascade;

begin;
alter table turma drop id_escola;
alter table turma add id_escola int not null references escola (id_escola) on update no action on delete cascade;
commit;

begin;
alter table aluno_turma drop id_aluno;
alter table aluno_turma drop id_turma;
alter table aluno_turma add id_turma int not null references turma (id_turma) on update no action on delete cascade;
alter table aluno_turma add id_aluno int not null references aluno (id_aluno) on update no action on delete cascade;
commit;

begin;
alter table aula drop id_disciplina;
alter table aula drop id_turma;
alter table aula drop id_professor;
alter table aula add id_turma int not null references turma (id_turma) on update no action on delete cascade;
alter table aula add id_disciplina int not null references disciplina (id_disciplina) on update no action on delete cascade;
alter table aula add id_professor int not null references professor (id_professor) on update no action on delete cascade;
commit;

begin;
alter table prova drop id_disciplina;
alter table prova add id_disciplina int not null references disciplina (id_disciplina) on update no action on delete cascade;
commit;

begin;
alter table aplicacao drop id_aula;
alter table aplicacao drop id_prova;
alter table aplicacao add id_prova int not null references prova (id_prova) on update no action on delete cascade;
alter table aplicacao add id_aula int not null references aula (id_aula) on update no action on delete cascade;
commit;

begin;
alter table questao drop id_disciplina;
alter table questao add id_disciplina int not null references disciplina (id_disciplina) on update no action on delete cascade;
commit;


begin;
alter table gabarito drop id_prova;
alter table gabarito drop id_questao;
alter table gabarito drop id_alternativa;
alter table gabarito add id_questao int not null references questao (id_questao) on update no action on delete cascade;
alter table gabarito add id_prova int not null references prova (id_prova) on update no action on delete cascade;
alter table gabarito add id_alternativa int not null references alternativa (id_alternativa) on update no action on delete cascade;
commit;

begin;
alter table resposta drop id_aluno;
alter table resposta drop id_aplicacao;
alter table resposta add id_aplicacao int not null references aplicacao (id_aplicacao) on update no action on delete cascade;
alter table resposta add id_aluno int not null references aluno (id_aluno) on update no action on delete cascade;
commit;



