-- Exemplo 1: Tabela Produto (Modificação simples)
-- Aumenta o valor do "precoAtual" especificamente do produto com ID 1 (Pizza Calabresa Grande) para 52.00.
UPDATE Produto 
SET precoAtual = 52.00
WHERE idProduto = 1;

-- Exemplo 2: Tabela Cliente (Modificação de múltiplos atributos)
-- Atualiza o bairro e insere um complemento no endereço do cliente "Bruno Santos" (idCliente = 2) que estava com o complemento nulo.
UPDATE Cliente 
SET bairro = 'Centro', complemento = 'Apto 101' 
WHERE idCliente = 2;

-- Exemplo 3: Tabela Entregador (Modificação com filtro exato)
-- Altera o tipo de veículo do entregador de ID 3 ("Arthur Cervero") de 'C' (Carro) para 'M' (Moto).
UPDATE Entregador 
SET tipoVeiculo = 'M'
WHERE idEntregador = 3;

-- Exemplo 4: Tabela Cupom (Modificação matemática)
-- Adiciona 5.00 de desconto ao valor já existente do cupom promocional chamado 'PROMO10'.
UPDATE Cupom SET valorDesconto = valorDesconto + 5.00 WHERE nomeCupom = 'PROMO10';

-- Exemplo 5: Tabela Pedido (UPDATE Aninhado / Subconsulta)
-- Atualiza o status para 'EN' (Entregue) em todos os pedidos que atualmente estão com status 'SA' (Saindo) 
-- e que estão vinculados ao entregador chamado "Daniel Hartmann".
UPDATE Pedido 
SET statusPedido = 'EN' 
WHERE statusPedido = 'SA' 
AND idEntregador IN (SELECT idEntregador 
                       		            FROM Entregador 
                       		            WHERE nomeEntregador = 'Daniel Hartmann');
