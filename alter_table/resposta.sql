ALTER TABLE resposta 
	ADD COLUMN id_aplicacao INT NOT NULL REFERENCES aplicacao(id_aplicacao);
	