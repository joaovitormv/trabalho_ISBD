-- Tabela 1: Cliente
INSERT INTO Cliente (cpfCliente, foneCliente, nomeCliente, logradouro, cidade, estado, cep, numero, bairro, complemento) VALUES
('11122233344', '31988881111', 'Ana Silva', 'Rua das Flores', 'Belo Horizonte', 'MG', '30100000', 100, 'Centro', 'Apto 201'),
('22233344455', '27999992222', 'Bruno Santos', 'Av. Central', 'Vitória', 'ES', '29000000', 550, 'Praia do Canto', NULL),
('33344455566', '31977773333', 'Carlos Oliveira', 'Rua das Palmeiras', 'Belo Horizonte', 'MG', '31200000', 42, 'Anchieta', 'Casa B'),
('44455566677', '27988884444', 'Daniela Souza', 'Rua São Mateus', 'Montanha', 'ES', '29890000', 12, 'Previsul', NULL),
('55566677788', '33999995555', 'Eduardo Costa', 'Av. Brasil', 'Nanuque', 'MG', '39860000', 1015, 'Urca', 'Fundos'),
('66677788899', '31966667777', 'Fernanda Lima', 'Rua Bahia', 'Belo Horizonte', 'MG', '30110002', 250, 'Lourdes', 'Apto 1001'),
('77788899900', '27977778888', 'Gabriel Almeida', 'Av. Dante Michelini', 'Vitória', 'ES', '29060000', 1200, 'Jardim Camburi', 'Bl A, Ap 402'),
('88899900011', '33988889999', 'Juliana Rocha', 'Rua São Paulo', 'Nanuque', 'MG', '39860000', 88, 'Centro', NULL),
('99900011122', '27999991111', 'Lucas Ribeiro', 'Rua dos Capixabas', 'Montanha', 'ES', '29890000', 340, 'Fundão', 'Casa'),
('00011122233', '31955554444', 'Mariana Costa', 'Av. Amazonas', 'Belo Horizonte', 'MG', '30180001', 1500, 'Barro Preto', 'Loja 3'),
('11133344422', '31944443333', 'Rodrigo Mendes', 'Rua Paraíba', 'Belo Horizonte', 'MG', '30130140', 12, 'Savassi', NULL),
('22244455533', '27933332222', 'Beatriz Fonseca', 'Rua Aleixo Neto', 'Vitória', 'ES', '29055000', 455, 'Praia do Canto', 'Sala 20'),
('33355566644', '33922221111', 'Ricardo Augusto', 'Rua Mucuri', 'Nanuque', 'MG', '39860000', 700, 'Urca', NULL),
('44466677755', '27911110000', 'Camila Pires', 'Av. Principal', 'Montanha', 'ES', '29890000', 95, 'Centro', NULL),
('55577788866', '31922223333', 'Gustavo Henrique', 'Rua Guajajaras', 'Belo Horizonte', 'MG', '30180010', 850, 'Centro', 'Apto 504'),
('66688899977', '31988882222', 'Larissa Manoela', 'Rua Sergipe', 'Belo Horizonte', 'MG', '30130170', 33, 'Funcionários', NULL),
('77799900088', '27999993333', 'Pedro Bial', 'Rua Saturnino de Brito', 'Vitória', 'ES', '29055100', 105, 'Praia do Canto', 'Casa 1'),
('88800011199', '33977775555', 'Amanda Sayuri', 'Av. Santos Dumont', 'Nanuque', 'MG', '39860000', 412, 'Vila Nova', NULL),
('99911122200', '27988886666', 'Thiago Fragoso', 'Rua Novo Horizonte', 'Montanha', 'ES', '29890000', 77, 'Previsul', NULL),
('12398745611', '31966664444', 'Isabela Swan', 'Rua dos Goitacazes', 'Belo Horizonte', 'MG', '30190010', 600, 'Barro Preto', 'Ap 12');

-- Tabela 2: Entregador
INSERT INTO Entregador (cpfEntregador, foneEntregador, nomeEntregador, tipoVeiculo) VALUES
('99988877766', '31966665544', 'Paulo Silveira', 'M'),
('88877766655', '27955554433', 'Marcos Jonas', 'B'),
('77766655544', '33944443322', 'Arthur Cervero', 'C'),
('66655544433', '31933332211', 'Elizabeth Webber', 'M'),
('55544433322', '27922221100', 'Daniel Hartmann', 'B');

-- Tabela 3: Restaurante
INSERT INTO Restaurante (cnpjRestaurante, nomeRestaurante, logradouro, cidade, estado, cep, numero, bairro, complemento) VALUES
('12345678000199', 'Pizzaria Bella Napoli', 'Rua dos Sabores', 'Belo Horizonte', 'MG', '30150000', 450, 'Savassi', NULL),
('98765432000188', 'Burguer Craft', 'Av. dos Lanches', 'Vitória', 'ES', '29050000', 22, 'Jardim da Penha', 'Loja A'),
('45678912000177', 'Sushi House', 'Rua do Oriente', 'Belo Horizonte', 'MG', '31300000', 888, 'Castelo', NULL),
('32165498000166', 'Cantina da Nonna', 'Rua Itália', 'Nanuque', 'MG', '39860000', 75, 'Centro', NULL),
('78912345000155', 'Sabor Caseiro', 'Av. Principal', 'Montanha', 'ES', '29890000', 500, 'Centro', 'Shopping');
-- Tabela 4: FoneRestaurante
INSERT INTO FoneRestaurante (idRestaurante, telefone) VALUES
(1, '3132221111'),
(1, '31988776655'),
(2, '2733445566'),
(3, '3134445555'),
(4, '3336214455');

-- Tabela 5: Produto
INSERT INTO Produto (idRestaurante, nomeProduto, precoAtual, descricao) VALUES
(1, 'Pizza Calabresa Grande', 49.90, 'Molho, muçarela, calabresa e cebola.'),
(1, 'Pizza Quatro Queijos', 49.90, 'Muçarela, catupiry, provolone e gorgonzola.'),
(2, 'Smash Burguer Clássico', 28.50, 'Pão, carne 100g, queijo prato e maionese artesanal.'),
(3, 'Combo Sushi 20 Peças', 62.00, '10 hossomaki, 5 uramaki e 5 niguiri.'),
(5, 'Prato Feito Executivo', 22.00, 'Arroz, feijão, carne, batata frita e salada.'),
(2, 'Batata Frita Turbinada', 18.00, 'Porção de batata frita com cheddar e bacon.'),
(2, 'Milkshake Ovomaltine 500ml', 15.00, 'Milkshake cremoso com pedaços de Ovomaltine.'),
(1, 'Pizza Frango com Catupiry', 47.00, 'Molho, muçarela, frango desfiado e catupiry original.'),
(3, 'Temaki Salmão Completo', 24.90, 'Cone de alga recheado com arroz, salmão, cream cheese e cebolinha.'),
(5, 'Suco Natural de Laranja 1L', 12.00, 'Suco 100% puro da fruta, sem adição de açúcar.'),
(4, 'Lasanha à Bolonhesa Família', 55.00, 'Massa artesanal, molho bolonhesa rico, presunto e muita muçarela.'),
(4, 'Fettuccine ao Molho Alfredo', 42.00, 'Massa fresca com molho cremoso à base de manteiga e queijo parmesão.');

-- Tabela 6: Categoria
INSERT INTO Categoria (nomeCategoria, descricao) VALUES
('Pizzas', 'Pizzas assadas no forno a lenha'),
('Hambúrgueres', 'Hambúrgueres artesanais e blends especiais'),
('Japonesa', 'Sushi, sashimi, temakis e combinados'),
('Prato Feito', 'Refeições individuais para o almoço'),
('Bebidas', 'Refrigerantes, sucos e águas');

-- Tabela 7: Classificado_em (relaciona Produto e Categoria)
INSERT INTO Classificado_em (idCategoria, idProduto) VALUES
(1, 1), -- Pizza Calabresa em Pizzas
(1, 2), -- Pizza Quatro Queijos em Pizzas
(2, 3), -- Smash Burguer em Hambúrgueres
(2, 6), -- Batata Frita em Hambúrgueres (acompanhamento)
(3, 4), -- Combo Sushi em Japonesa
(4, 5), -- Prato Feito em Prato Feito
(5, 7), -- Milkshake em Bebidas
(1, 8), -- Pizza Frango com Catupiry em Pizzas
(3, 9), -- Temaki Salmão em Japonesa
(5, 10), -- Suco Natural em Bebidas
(4, 11), -- Lasanha em Prato Feito
(4, 12); -- Fettuccine em Prato Feito

-- Tabela 8: Cupom
INSERT INTO Cupom (nomeCupom, valorDesconto, dataCriacao, dataValidade) VALUES
('PROMO10', 10.00, '2026-06-01', '2026-06-30'),
('QUEROVINTE', 20.00, '2026-06-10', '2026-07-10'),
('DESCONTO5', 5.00, '2026-05-01', '2026-06-25'),
('CUPOMESPECIAL', 12.50, '2026-06-15', '2026-06-20'),
('BEMVINDO', 15.00, '2026-01-01', '2026-12-31');

-- Tabela 9: Pedido
-- Status válidos: 'PE' (Pendente), 'PR' (Preparando), 'SA' (Saindo), 'EN' (Entregue), 'CA' (Cancelado)
INSERT INTO Pedido (idCliente, idEntregador, idRestaurante, dataPedido, horaPedido, statusPedido) VALUES
(1, 1, 1, '2026-06-15', '19:30:00', 'EN'),
(2, 2, 2, '2026-06-16', '20:15:00', 'EN'),
(3, 1, 3, '2026-06-17', '12:00:00', 'PR'),
(4, 4, 5, '2026-06-17', '13:10:00', 'SA'),
(5, 3, 4, '2026-06-17', '21:00:00', 'PE'),
(6, 1, 1, '2026-06-18', '19:00:00', 'EN'),
(7, 2, 2, '2026-06-18', '19:15:00', 'EN'),
(8, 3, 4, '2026-06-18', '19:45:00', 'EN'),
(9, 4, 5, '2026-06-18', '20:00:00', 'CA'),
(10, 5, 3, '2026-06-18', '20:30:00', 'EN'),
(11, 1, 1, '2026-06-18', '21:00:00', 'EN'),
(12, 2, 2, '2026-06-18', '21:15:00', 'SA'),
(13, 3, 4, '2026-06-18', '21:30:00', 'PR'),
(14, 4, 5, '2026-06-18', '22:00:00', 'PE'),
(15, 5, 3, '2026-06-18', '22:15:00', 'PE'),
(6, 1, 1, '2026-06-19', '11:30:00', 'EN'),
(7, 2, 2, '2026-06-19', '12:00:00', 'EN'),
(18, 3, 4, '2026-06-19', '12:15:00', 'EN'),
(19, 4, 5, '2026-06-19', '13:00:00', 'EN'),
(20, 5, 3, '2026-06-19', '13:30:00', 'CA');

-- Tabela 10: Composto_por (relaciona Pedido e Produto)
INSERT INTO Composto_por (idPedido, idProduto, quantidadeProduto, precoPedido) VALUES
(1, 1, 2, 45.90), -- 2x Pizza Calabresa (91.80)
(2, 3, 1, 28.50), -- 1x Smash Burguer (28.50)
(3, 4, 1, 62.00), -- 1x Combo Sushi (62.00)
(4, 5, 2, 22.00), -- 2x Prato Feito (44.00)
(5, 11, 1, 55.00), -- 1x Lasanha Família (55.00)
(6, 8, 1, 47.00),  -- 1x Pizza Frango Catupiry (47.00)
(7, 3, 2, 28.50),  -- 2x Smash Burguer (57.00)
(7, 6, 1, 18.00),  -- 1x Batata Frita (18.00) -> Total pedido: 75.00
(8, 12, 1, 42.00), -- 1x Fettuccine Alfredo (42.00)
(9, 10, 2, 12.00), -- 2x Suco de Laranja (24.00)
(10, 4, 1, 62.00), -- 1x Combo Sushi (62.00)
(10, 9, 2, 24.90), -- 2x Temaki Salmão (49.80) -> Total pedido: 111.80
(11, 1, 1, 45.90), -- 1x Pizza Calabresa (45.90)
(12, 3, 1, 28.50), -- 1x Smash Burguer (28.50)
(12, 7, 1, 15.00), -- 1x Milkshake (15.00) -> Total pedido: 43.50
(13, 12, 1, 42.00), -- 1x Fettuccine Alfredo (42.00)
(14, 5, 2, 22.00), -- 2x Prato Feito (44.00)
(15, 4, 1, 62.00), -- 1x Combo Sushi (62.00)
(16, 2, 1, 49.90), -- 1x Pizza Quatro Queijos (49.90)
(17, 3, 2, 28.50), -- 2x Smash Burguer Clássico (57.00)
(18, 11, 1, 55.00), -- 1x Lasanha Família (55.00)
(19, 5, 1, 22.00), -- 1x Prato Feito (22.00)
(20, 4, 1, 62.00); -- 1x Combo Sushi (62.00)

-- Tabela 11: Eh_aplicado_em (relaciona Pedido e Cupom)
INSERT INTO Eh_aplicado_em (idPedido, idCupom) VALUES
(1, 1), -- Cupom PROMO10 no Pedido 1
(2, 2), -- Cupom QUEROVINTE no Pedido 2
(3, 4), -- Cupom CUPOMESPECIAL no Pedido 3
(4, 3), -- Cupom DESCONTO5 no Pedido 4
(5, 5); -- Cupom BEMVINDO no Pedido 5

-- Tabela 12: Pagamento
-- Formas: 'CR', 'DB', 'PX', 'DN', 'VR', 'CD' | Status: 'P' (Pendente), 'A' (Aprovado), 'R' (Recusado), 'C' (Cancelado)
INSERT INTO Pagamento (idPedido, formaPagamento, statusPagamento, valorPagamento) VALUES
(1, 'PX', 'A', 81.80), -- 91.80 - 10.00 cupom
(2, 'CR', 'A', 8.50), -- 28.50 - 20.00 cupom
(3, 'DB', 'A', 49.50), -- 62.00 - 12.50 cupom
(4, 'DN', 'P', 39.00), -- 44.00 - 5.00 cupom
(5, 'PX', 'P', 40.00), -- 55.00 - 15.00 cupom
(6, 'CR', 'A', 47.00), -- Sem cupom
(7, 'PX', 'A', 75.00), -- Sem cupom (57.00 + 18.00)
(8, 'DN', 'A', 42.00), -- Sem cupom
(9, 'CR', 'C', 24.00), -- Cancelado (24.00)
(10, 'PX', 'A', 111.80), -- Sem cupom (62.00 + 49.80)
(11, 'DB', 'A', 45.90), -- Sem cupom
(12, 'CR', 'A', 43.50), -- Sem cupom (28.50 + 15.00)
(13, 'VR', 'P', 42.00), -- Sem cupom
(14, 'PX', 'P', 44.00), -- Sem cupom (22.00 * 2)
(15, 'CR', 'P', 62.00), -- Sem cupom
(16, 'DB', 'A', 49.90), -- Sem cupom
(17, 'PX', 'A', 57.00), -- Sem cupom (28.50 * 2)
(18, 'DN', 'A', 55.00), -- Sem cupom
(19, 'VR', 'A', 22.00), -- Sem cupom
(20, 'CR', 'C', 62.00); -- Cancelado (62.00)

-- Tabela 13: Avaliacao
INSERT INTO Avaliacao (idPedido, idCliente, nota, comentario) VALUES
(1, 1, 5.0, 'Pizzas maravilhosas, chegaram super quentinhas!'),
(2, 2, 4.5, 'Muito gostoso, mas o motoboy demorou um pouco.'),
(6, 6, 4.0, 'A pizza estava boa, mas a borda veio um pouco queimada.'),
(7, 7, 5.0, 'O hambúrguer artesanal é imbatível! Entrega super rápida.'),
(8, 8, 3.5, 'Massa muito saborosa. Vale o preço do Fettuccine.'),
(10, 10, 5.0, 'Melhor combinado de sushi da cidade. Tudo muito fresco.'),
(11, 11, 4.2, 'A pizza de calabresa estava excelente, só achei que faltou um pouco mais de cebola.'),
(16, 6, 5.0, 'Segunda vez que peço e continua excelente.'),
(17, 7, 4.0, 'Hambúrguer muito suculento e no ponto certo! Só achei que veio com muito recheio.'),
(18, 18, 4.5, 'Lasanha quentinha, bem embalada.'),
(19, 19, 1.0, 'Péssimo. Veio revirado na sacola.');
