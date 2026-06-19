CREATE SCHEMA IF NOT EXISTS SistemaDelivery DEFAULT CHARACTER SET utf8;
USE SistemaDelivery;

CREATE TABLE IF NOT EXISTS Cliente (
	idCliente	INT			NOT NULL	AUTO_INCREMENT,
	cpfCliente	CHAR(11)	 	NOT NULL,
	foneCliente	CHAR(11)	 	NOT NULL,
	nomeCliente	VARCHAR(80)  	NOT NULL,
	logradouro	VARCHAR(40)  	NOT NULL,
	cidade		VARCHAR(30)  	NOT NULL,
	estado		CHAR(2)		NOT NULL,
	cep		CHAR(8)		NOT NULL,
	numero	INT UNSIGNED 	NOT NULL,
	bairro		VARCHAR(30)  	NULL,
	complemento	VARCHAR(20)  	NULL,
	PRIMARY KEY (idCliente),
	UNIQUE INDEX cpfCliente_UNIQUE (cpfCliente ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Entregador (
	idEntregador		INT			NOT NULL	AUTO_INCREMENT,
	cpfEntregador		CHAR(11)		NOT NULL,
	foneEntregador	CHAR(11)		NOT NULL,
	nomeEntregador	VARCHAR(80) 	NOT NULL,
	tipoVeiculo		CHAR(1)		NOT NULL,
	PRIMARY KEY (idEntregador),
	UNIQUE INDEX cpfEntregador_UNIQUE (cpfEntregador ASC) VISIBLE,
	CONSTRAINT chk_tipoVeiculo CHECK (tipoVeiculo IN ('M', 'B', 'C')))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Restaurante (
	idRestaurante		INT			NOT NULL	AUTO_INCREMENT,
	cnpjRestaurante	CHAR(14)		NOT NULL,
	nomeRestaurante	VARCHAR(40)   	NOT NULL,
	logradouro		VARCHAR(40)   	NOT NULL,
	cidade			VARCHAR(30)   	NOT NULL,
	estado			CHAR(2)		NOT NULL,
	cep			CHAR(8)		NOT NULL,
	numero		INT UNSIGNED  	NOT NULL,
	bairro			VARCHAR(30)	NULL,
	complemento		VARCHAR(20)	NULL,
	PRIMARY KEY (idRestaurante),
	UNIQUE INDEX cnpjRestaurante_UNIQUE (cnpjRestaurante ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Pedido (
	idPedido		INT		NOT NULL	AUTO_INCREMENT,
	idCliente		INT		NOT NULL,
	idEntregador		INT 	 	NOT NULL,
	idRestaurante		INT		NOT NULL,
	dataPedido		DATE	  	NOT NULL	DEFAULT (CURRENT_DATE),
	horaPedido		TIME	  	NOT NULL	DEFAULT (CURRENT_TIME),
	statusPedido		CHAR(2)	NOT NULL	DEFAULT 'PE',
	PRIMARY KEY (idPedido),
	INDEX fk_Pedido_Cliente_idx (idCliente ASC) VISIBLE,
	INDEX fk_Pedido_Entregador_idx (idEntregador ASC) VISIBLE,
	INDEX fk_Pedido_Restaurante_idx (idRestaurante ASC) VISIBLE,
	CONSTRAINT chk_statusPedido CHECK (statusPedido IN ('PE', 'PR', 'SA', 'EN', 'CA')),
	CONSTRAINT fk_Pedido_Cliente
		FOREIGN KEY (idCliente)
		REFERENCES Cliente (idCliente)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Pedido_Entregador
		FOREIGN KEY (idEntregador)
		REFERENCES Entregador (idEntregador)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Pedido_Restaurante
		FOREIGN KEY (idRestaurante)
		REFERENCES Restaurante (idRestaurante)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Avaliacao (
	idPedido	INT			NOT NULL,
	idCliente	INT 		 	NOT NULL,
	nota		DECIMAL(2,1) 	NOT NULL,
	comentario  	VARCHAR(255) 	NULL,
	PRIMARY KEY (idPedido),
	INDEX fk_Avaliacao_Cliente_idx (idCliente ASC) VISIBLE,
	CONSTRAINT chk_nota CHECK (nota BETWEEN 0.0 AND 5.0),
	CONSTRAINT fk_Avaliacao_Cliente
		FOREIGN KEY (idCliente)
		REFERENCES Cliente (idCliente)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Avaliacao_Pedido
		FOREIGN KEY (idPedido)
		REFERENCES Pedido (idPedido)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Cupom (
	idCupom	INT			  	NOT NULL  AUTO_INCREMENT,
	nomeCupom	VARCHAR(30)		NOT NULL,
	valorDesconto DECIMAL(5,2) UNSIGNED 	NOT NULL,
	dataCriacao	DATE				NOT NULL,
	dataValidade	DATE				NOT NULL,
	PRIMARY KEY (idCupom))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Pagamento (
	idPedido 		INT		  		NOT NULL,
	formaPagamento	CHAR(2)	  		NOT NULL,
	statusPagamento	CHAR(1)	  		NOT NULL,
	valorPagamento  	DECIMAL(5,2) UNSIGNED	NOT NULL,
	PRIMARY KEY (idPedido),
	CONSTRAINT chk_formaPagamento CHECK (formaPagamento IN ('CR', 'DB', 'PX', 'DN', 'VR', 'CD')),
	CONSTRAINT chk_statusPagamento CHECK (statusPagamento IN ('P', 'A', 'R', 'C')),
	CONSTRAINT fk_Pagamento_Pedido
		FOREIGN KEY (idPedido)
		REFERENCES Pedido (idPedido)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Produto (
	idProduto	  INT				NOT NULL	AUTO_INCREMENT,
	idRestaurante	  INT				NOT NULL,
	nomeProduto	  VARCHAR(50)		NOT NULL,
	precoAtual	  DECIMAL(5,2) UNSIGNED 	NOT NULL,
	descricao	  VARCHAR(255)		NULL,
	PRIMARY KEY (idProduto),
	INDEX fk_Produto_Restaurante_idx (idRestaurante ASC) VISIBLE,
	CONSTRAINT fk_Produto_Restaurante
		FOREIGN KEY (idRestaurante)
		REFERENCES Restaurante (idRestaurante)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS FoneRestaurante (
	idRestaurante  INT		NOT NULL,
	telefone	 CHAR(11)	NOT NULL,
	PRIMARY KEY (idRestaurante, telefone),
	INDEX fk_FoneRestaurante_Restaurante_idx (idRestaurante ASC) VISIBLE,
	CONSTRAINT fk_FoneRestaurante_Restaurante
		FOREIGN KEY (idRestaurante)
		REFERENCES Restaurante (idRestaurante)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Categoria (
	idCategoria	  INT		   	NOT NULL AUTO_INCREMENT,
	nomeCategoria VARCHAR(30)  	NOT NULL,
	descricao	  VARCHAR(100) 	NULL,
	PRIMARY KEY (idCategoria),
	UNIQUE INDEX nomeCategoria_UNIQUE (nomeCategoria ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Eh_aplicado_em (
	idPedido	INT NOT NULL,
	idCupom	INT NOT NULL,
	PRIMARY KEY (idPedido, idCupom),
	INDEX fk_Pedido_has_Cupom_Cupom_idx (idCupom ASC) VISIBLE,
	INDEX fk_Pedido_has_Cupom_Pedido_idx (idPedido ASC) VISIBLE,
	CONSTRAINT fk_Pedido_has_Cupom_Pedido
		FOREIGN KEY (idPedido)
		REFERENCES Pedido (idPedido)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Pedido_has_Cupom_Cupom
		FOREIGN KEY (idCupom)
		REFERENCES Cupom (idCupom)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Composto_por (
	idPedido		INT		   NOT NULL,
	idProduto		INT		   NOT NULL,
	quantidadeProduto 	INT 		   NOT NULL,
	precoPedido		DECIMAL(5,2)	   NOT NULL,
	PRIMARY KEY (idPedido, idProduto),
	INDEX fk_Pedido_has_Produto_Produto_idx (idProduto ASC) VISIBLE,
	INDEX fk_Pedido_has_Produto_Pedido_idx (idPedido ASC) VISIBLE,
	CONSTRAINT fk_Pedido_has_Produto_Pedido
		FOREIGN KEY (idPedido)
		REFERENCES Pedido (idPedido)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Pedido_has_Produto_Produto
		FOREIGN KEY (idProduto)
		REFERENCES Produto (idProduto)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Classificado_em (
	idCategoria 	INT NOT NULL,
	idProduto   	INT NOT NULL,
	PRIMARY KEY (idCategoria, idProduto),
	INDEX fk_Categoria_has_Produto_Produto_idx (idProduto ASC) VISIBLE,
	INDEX fk_Categoria_has_Produto_Categoria_idx (idCategoria ASC) VISIBLE,
	CONSTRAINT fk_Categoria_has_Produto_Categoria
		FOREIGN KEY (idCategoria)
		REFERENCES Categoria (idCategoria)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Categoria_has_Produto_Produto
		FOREIGN KEY (idProduto)
		REFERENCES Produto (idProduto)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Restaurante (cnpjRestaurante, nomeRestaurante, logradouro, cidade, estado, cep, numero, bairro, complemento) VALUES
('12345678000199', 'Pizzaria Bella Napoli', 'Rua dos Sabores', 'Belo Horizonte', 'MG', '30150000', 450, 'Savassi', NULL),
('98765432000188', 'Burguer Craft', 'Av. dos Lanches', 'Vitória', 'ES', '29050000', 22, 'Jardim da Penha', 'Loja A'),
('45678912000177', 'Sushi House', 'Rua do Oriente', 'Belo Horizonte', 'MG', '31300000', 888, 'Castelo', NULL),
('32165498000166', 'Cantina da Nonna', 'Rua Itália', 'Nanuque', 'MG', '39860000', 75, 'Centro', NULL),
('78912345000155', 'Sabor Caseiro', 'Av. Principal', 'Montanha', 'ES', '29890000', 500, 'Centro', 'Shopping');
