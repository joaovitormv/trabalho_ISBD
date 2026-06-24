-- 0. Remove os usuários antigos do servidor, caso já existam
DROP USER IF EXISTS 'gerente_delivery'@'localhost';
DROP USER IF EXISTS 'atendente_delivery'@'localhost';

-- Cria os usuários do zero e de forma limpa
CREATE USER 'gerente_delivery'@'localhost' IDENTIFIED BY 'Gerente#2026';
CREATE USER 'atendente_delivery'@'localhost' IDENTIFIED BY 'Atende@123';

-- 1. CRIAÇÃO DOS USUÁRIOS
CREATE USER 'gerente_delivery'@'localhost' IDENTIFIED BY 'Gerente#2026';
CREATE USER 'atendente_delivery'@'localhost' IDENTIFIED BY 'Atende@123';

-- 2. CONCESSÃO DE PERMISSÕES
-- O gerente tem controle total de leitura e escrita nas tabelas operacionais
GRANT SELECT, INSERT, UPDATE, DELETE ON Produto TO 'gerente_delivery'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON Entregador TO 'gerente_delivery'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Pedido TO 'gerente_delivery'@'localhost';

-- O atendente só pode consultar o sistema e atualizar o status do pedido na rotina diária
GRANT SELECT ON Cliente TO 'atendente_delivery'@'localhost';
GRANT SELECT ON Produto TO 'atendente_delivery'@'localhost';
GRANT SELECT, UPDATE(statusPedido) ON Pedido TO 'atendente_delivery'@'localhost';

-- 3. REVOGAÇÃO DE PERMISSÕES
-- Revogando a permissão do atendente de atualização. Ele volta a ser um usuário exclusivamente de consulta.
REVOKE UPDATE ON Pedido FROM 'atendente_delivery'@'localhost';

-- 4. APLICAÇÃO DAS ALTERAÇÕES
FLUSH PRIVILEGES;
