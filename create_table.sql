-- CRIACAO DAS TABELAS DO BANCO DE DADOS


CREATE TABLE aluno(
    id_aluno serial NOT NULL PRIMARY KEY,
    nome_aluno varchar(255) NOT NULL,
    nascimento_aluno DATE NOT NULL,
    matricula_aluno varchar(10) NOT NULL
);
 
CREATE TABLE escola(
    id_escola serial NOT NULL PRIMARY KEY,
    nome varchar(255) NOT NULL,
    numero INT NOT NULL,
    complemento varchar(255),
    cep varchar(8) NOT NULL
);
 
CREATE TABLE turma(
    id_turma serial NOT NULL PRIMARY KEY,
    ano INT NOT NULL,
    sigla char(1) NOT NULL,
    turno char(5), NOT NULL,
    e_medio bool NOT NULL,
    id_escola INT NOT NULL REFERENCES escola(id_escola) ON DELETE CASCADE
);
 
CREATE TABLE aluno_turma(
    id_aluno_turma serial NOT NULL PRIMARY KEY,
    id_aluno INT NOT NULL REFERENCES aluno(id_aluno) ON DELETE CASCADE,
    id_turma INT NOT NULL REFERENCES turma(id_turma) ON DELETE CASCADE,
    DATA DATE DEFAULT NOW()
);
 
CREATE TABLE professor(
    id_professor serial NOT NULL PRIMARY KEY,
    nome_professor varchar(255) NOT NULL,
    nascimento_professor DATE NOT NULL,
    cpf varchar(11) NOT NULL,
    matricula_professor varchar(10) NOT NULL
);
 
CREATE TABLE disciplina(
    id_disciplina serial NOT NULL PRIMARY KEY,
    descricao varchar(255) NOT NULL,
    ano INT NOT NULL,
    e_medio bool NOT NULL
);
 
CREATE TABLE aula(
    id_aula serial NOT NULL PRIMARY KEY,
    id_turma INT NOT NULL REFERENCES turma(id_turma) ON DELETE CASCADE,
    id_professor INT NOT NULL REFERENCES professor(id_professor) ON DELETE CASCADE,
    id_disciplina INT NOT NULL REFERENCES disciplina(id_disciplina) ON DELETE CASCADE,
    ano_letivo INT DEFAULT EXTRACT(YEAR FROM NOW())
);
 
CREATE TABLE prova(
    id_prova serial NOT NULL PRIMARY KEY,
    id_disciplina INT REFERENCES disciplina(id_disciplina) ON DELETE CASCADE,
    finalizada bool DEFAULT FALSE
);
 
 
CREATE TABLE aplicacao(
    id_aplicacao serial NOT NULL PRIMARY KEY,
    id_aula INT NOT NULL REFERENCES aula(id_aula) ON DELETE CASCADE,
    id_prova INT NOT NULL REFERENCES prova(id_prova) ON DELETE CASCADE,
    data_aplicacao DATE NOT NULL
);
 
CREATE TABLE questao(
    id_questao serial NOT NULL PRIMARY KEY,
    enunciado varchar(500) NOT NULL,
    id_disciplina INT NOT NULL REFERENCES disciplina(id_disciplina) ON DELETE CASCADE,
    finalizada bool DEFAULT FALSE
);
 
CREATE TABLE alternativa(
    id_alternativa serial NOT NULL PRIMARY KEY,
    descricao varchar(255)
);
 
CREATE TABLE gabarito (
    id_gabarito serial NOT NULL PRIMARY KEY,
    id_prova INT NOT NULL REFERENCES prova(id_prova) ON DELETE CASCADE,
    id_questao INT NOT NULL REFERENCES questao(id_questao) ON DELETE CASCADE,
    id_alternativa INT NOT NULL REFERENCES alternativa(id_alternativa) ON DELETE CASCADE,
    e_certo bool NOT NULL
);
 
CREATE TABLE resposta(
    id_resposta serial NOT NULL PRIMARY KEY,
    id_aluno INT NOT NULL REFERENCES aluno(id_aluno) ON DELETE CASCADE,
    id_gabarito INT NOT NULL REFERENCES gabarito(id_gabarito) ON DELETE CASCADE
);