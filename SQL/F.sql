-- F1:
-- O que recupera: O nome do produto, o seu preço atual e o nome do restaurante responsável, filtrando apenas produtos que custam mais de R$ 30,00.
SELECT P.nomeProduto, P.precoAtual, R.nomeRestaurante
FROM Produto P
INNER JOIN Restaurante R ON P.idRestaurante = R.idRestaurante
WHERE P.precoAtual > 30.00;

-- F2:
-- O que recupera: O nome de todos os clientes cadastrados e os detalhes de suas avaliações (nota e comentário). Por ser um LEFT JOIN, a consulta inclui clientes que nunca realizaram uma avaliação.
SELECT C.nomeCliente, A.nota, A.comentario
FROM Cliente C
LEFT OUTER JOIN Avaliacao A ON C.idCliente = A.idCliente;

-- F3:
-- O que recupera: O nome do cliente, a data e o status dos pedidos realizados por clientes do estado de Minas Gerais ('MG'), ordenados da data mais recente para a mais antiga e, em seguida, por nome em ordem alfabética.
SELECT C.nomeCliente, P.dataPedido, P.statusPedido
FROM Pedido P
INNER JOIN Cliente C ON P.idCliente = C.idCliente
WHERE C.estado = 'MG'
ORDER BY P.dataPedido DESC, C.nomeCliente ASC;

-- F4:
-- O que recupera: A identificação e o nome de cada restaurante, juntamente com o preço médio dos produtos oferecidos por cada um deles.
SELECT R.idRestaurante, R.nomeRestaurante, AVG(P.precoAtual) AS precoMedioProdutos
FROM Restaurante R
INNER JOIN Produto P ON R.idRestaurante = P.idRestaurante
GROUP BY R.idRestaurante, R.nomeRestaurante;

-- F5:
-- O que recupera: O nome das categorias de produtos e a quantidade total de itens cadastrados em cada uma, listando apenas as categorias que possuem mais de 1 produto vinculado.
SELECT C.nomeCategoria, COUNT(CE.idProduto) AS totalProdutos
FROM Categoria C
INNER JOIN Classificado_em CE ON C.idCategoria = CE.idCategoria
GROUP BY C.idCategoria, C.nomeCategoria
HAVING COUNT(CE.idProduto) > 1;

-- F6:
-- O que recupera: Uma lista consolidada de nomes e telefones de todos os usuários do sistema, identificando se o registro pertence a um 'Cliente' ou a um 'Entregador'.
SELECT nomeCliente AS nomePessoa, foneCliente AS telefoneContato, 'Cliente' AS tipoUsuario
FROM Cliente
UNION
SELECT nomeEntregador AS nomePessoa, foneEntregador AS telefoneContato, 'Entregador' AS tipoUsuario
FROM Entregador;

-- F7:
-- O que recupera: Os dados básicos (ID, data e status) dos pedidos cujo pagamento foi aprovado ('A') e realizado através de Pix ('PX') ou Cartão de Crédito ('CR').
SELECT P.idPedido, P.dataPedido, P.statusPedido
FROM Pedido P
WHERE P.idPedido IN (SELECT PAG.idPedido
FROM Pagamento PAG
WHERE PAG.formaPagamento IN ('PX', 'CR')
AND PAG.statusPagamento = 'A');

-- F8:
-- O que recupera: O nome, a cidade e o bairro dos clientes cujos nomes começam com a letra 'A' ou que possuem o sobrenome 'Silva' em qualquer parte do nome.
SELECT nomeCliente, cidade, bairro
FROM Cliente
WHERE nomeCliente LIKE 'A%' OR nomeCliente LIKE '%Silva%';

-- F9:
-- O que recupera: O nome e o endereço completo dos clientes que não informaram um 'complemento' (como número de apartamento ou bloco) em seu cadastro
SELECT nomeCliente, logradouro, numero, bairro, cidade
FROM Cliente
WHERE complemento IS NULL;

-- F10:
-- O que recupera: O nome e o preço atual dos produtos que já foram vendidos, em pelo menos uma ocasião, por um valor menor do que o seu preço de tabela atual.
SELECT nomeProduto, precoAtual
FROM Produto P
WHERE P.precoAtual > ANY (SELECT CP.precoPedido 
            FROM Composto_por CP 
            WHERE CP.idProduto = P.idProduto);

-- F11:
-- O que recupera: O nome e o preço do(s) produto(s) mais caro(s) do sistema, ou seja, aqueles cujo preço é maior ou igual ao preço de todos os outros produtos cadastrados.
SELECT nomeProduto, precoAtual
FROM Produto
WHERE precoAtual >= ALL (SELECT precoAtual
          FROM Produto);

-- F12:
-- O que recupera: O nome dos restaurantes que já tiveram, no mínimo, um pedido com o status de 'Entregue' ('EN') registrado no sistema.
SELECT R.nomeRestaurante
FROM Restaurante R
WHERE EXISTS (SELECT 1
     FROM Pedido P
     WHERE P.idRestaurante = R.idRestaurante 
     	    AND P.statusPedido = 'EN');

-- Complemento da Questão F: Outras Consultas
-- F13: Consulta com BETWEEN e AND
-- O que recupera: O nome do cupom e o seu valor de desconto para todos os cupons que foram criados no mês de junho de 2026 e que possuem um valor de desconto situado na faixa entre 10.00 e 20.00, inclusive.
SELECT nomeCupom, valorDesconto
FROM Cupom
WHERE (dataCriacao BETWEEN '2026-06-01' AND '2026-06-30')
AND (valorDesconto BETWEEN 10.00 AND 20.00);

-- F14: Consulta com NOT
-- O que recupera: O nome do cliente e a cidade de residência para pedidos que não foram cancelados ('CA'), onde a forma de pagamento utilizada foi 'Cartão de Crédito' (CR) ou 'Pix' (PX), e o valor total pago foi superior à 80.00.
SELECT DISTINCT C.nomeCliente, C.cidade
FROM Cliente C
INNER JOIN Pedido P ON C.idCliente = P.idCliente
INNER JOIN Pagamento PAG ON P.idPedido = PAG.idPedido
WHERE NOT P.statusPedido = 'CA'
AND (PAG.formaPagamento = 'CR' OR PAG.formaPagamento = 'PX')
AND PAG.valorPagamento > 80.00;