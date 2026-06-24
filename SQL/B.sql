-- Exemplo de criação e remoção de uma tabela extra apenas como exemplo
CREATE TABLE TabelaExemplo (
    idExemplo INT AUTO_INCREMENT PRIMARY KEY,
    observacao VARCHAR(50)
);

-- Exemplo 1: Adicionando uma nova coluna na tabela extra
ALTER TABLE TabelaExemplo ADD email VARCHAR(100);

-- Exemplo 2: Modificando uma coluna existente na tabela extra (alterando o tamanho do VARCHAR)
ALTER TABLE TabelaExemplo MODIFY COLUMN observacao VARCHAR(150);

-- Exemplo 3: Removendo uma coluna da tabela extra
ALTER TABLE TabelaExemplo DROP COLUMN email;

-- Apagando a tabela extra
DROP TABLE TabelaExemplo;
