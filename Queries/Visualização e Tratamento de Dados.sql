-- Visualizando as tabelas
SELECT * from categorias;
SELECT * from fornecedores;
SELECT * from marcas;
-- Visualizando as quantidades em cada tabela
SELECT COUNT(*) as Qtd_Categorias FROM categorias;
SELECT COUNT(*) as Qtd_Clientes  FROM clientes;
SELECT COUNT(*) as Qtd_Fornecedores  FROM fornecedores;
SELECT COUNT(*) as Qtd_ItensVenda  FROM itens_venda;
SELECT COUNT(*) as Qtd_Marcas  FROM marcas;
SELECT COUNT(*) as Qtd_Produtos  from produtos;
SELECT COUNT(*) as Qtd_Vendas  from vendas;
-- Unindo as informações para tornalas mais legiveis 
SELECT COUNT(*) as Qtd, 'Categorias' as Tabela FROM categorias
UNION ALL
SELECT COUNT(*) as Qtd, 'Clientes' as Tabela FROM clientes
UNION ALL
SELECT COUNT(*) as Qtd, 'Fornecedores' as Tabela FROM fornecedores
UNION ALL
SELECT COUNT(*) as Qtd, 'ItensVenda' as Tabela FROM itens_venda
UNION ALL
SELECT COUNT(*) as Qtd, 'Marcas' as Tabela FROM marcas
UNION ALL
SELECT COUNT(*) as Qtd, 'Produtos' as Tabela FROM produtos
UNION ALL
SELECT COUNT(*) as Qtd, 'Vendas' as Tabela FROM vendas;
-- Tratando dados incorretos
SELECT preco FROM produtos where nome_produto = 'Bola de Futebol';
UPDATE produtos SET preco = 100 where  nome_produto = 'Bola de Futebol' AND preco > 100;