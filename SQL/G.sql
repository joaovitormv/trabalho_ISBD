-- VISÃO 1: Relatório de Pedidos do Cliente
-- Cria uma visão que junta dados do Pedido com o nome do Cliente, o nome do Restaurante e o valor final pago.
CREATE VIEW PedidosCliente AS
SELECT C.nomeCliente, R.nomeRestaurante, P.dataPedido, P.statusPedido, PAG.valorPagamento
FROM Pedido P
JOIN Cliente C ON P.idCliente = C.idCliente
JOIN Restaurante R ON P.idRestaurante = R.idRestaurante
JOIN Pagamento PAG ON P.idPedido = PAG.idPedido;

-- Exemplo de uso da VISÃO 1:
-- Lista de forma rápida o nome do cliente, onde ele comprou e quanto pagou, filtrando apenas os pedidos entregues com sucesso.
SELECT nomeCliente, nomeRestaurante, valorPagamento 
FROM PedidosCliente 
WHERE statusPedido = 'EN';


-- VISÃO 2: Cardápio por Categoria
-- Cria uma visão que correlaciona os produtos cadastrados com os nomes textuais de suas respectivas categorias através da tabela Classificado_em.
CREATE VIEW CardapioCategoria AS
SELECT CAT.nomeCategoria, P.nomeProduto, P.precoAtual
FROM Produto P
JOIN Classificado_em C ON P.idProduto = C.idProduto
JOIN Categoria CAT ON C.idCategoria = CAT.idCategoria;

-- Exemplo de uso da VISÃO 2:
-- Consulta na visão os produtos pertencentes à categoria 'Pizzas' e os exibe ordenados do preço mais caro para o mais barato.
SELECT nomeProduto, precoAtual 
FROM CardapioCategoria 
WHERE nomeCategoria = 'Pizzas' 
ORDER BY precoAtual DESC;


-- VISÃO 3: Resumo de Avaliações dos Restaurantes
-- Cria uma visão cruzando os restaurantes com os pedidos e suas avaliações para gerar um sumário automático com a nota média.
CREATE VIEW ResumoAvaliacoes AS
SELECT R.nomeRestaurante, COUNT(A.idPedido) AS qtdeAvaliacoes, AVG(A.nota) AS notaMedia
FROM Restaurante R
JOIN Pedido P ON R.idRestaurante = P.idRestaurante
JOIN Avaliacao A ON P.idPedido = A.idPedido
GROUP BY R.idRestaurante, R.nomeRestaurante;

-- Exemplo de uso da VISÃO 3:
-- Utiliza o resumo já calculado na visão para listar apenas os nomes dos restaurantes considerados de excelência (nota média >= 4.5).
SELECT nomeRestaurante, notaMedia 
FROM ResumoAvaliacoes 
WHERE notaMedia >= 4.5;
