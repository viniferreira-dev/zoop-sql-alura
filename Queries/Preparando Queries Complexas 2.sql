--Calculando a Participação de Mercado de MarcasPreparando Queries Complexas
SELECT Nome_Marca, Qtd_Vendas_Marcas, ROUND(100.0 * Qtd_Vendas_Marcas / (SELECT COUNT(*) FROM itens_venda), 2) AS Porcentagem
FROM (
	SELECT m.nome AS Nome_Marca, COUNT(iv.produto_id) as Qtd_Vendas_Marcas FROM marcas m
	JOIN produtos p ON p.marca_id = m.id_marca
	JOIN itens_venda iv ON iv.produto_id = p.id_produto
	group by m.nome)
    order by Porcentagem DESC;
--Calculando a Participação de Mercado de Fornecedores
SELECT Nome_Fornecedor, Qtd_Vendas_Forncedores, ROUND(100.0 * Qtd_Vendas_Forncedores / (SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM (
	SELECT f.nome as Nome_Fornecedor, COUNT(iv.produto_id) as Qtd_Vendas_Forncedores FROM fornecedores f
	JOIN produtos p ON p.fornecedor_id = f.id_fornecedor
	JOIN itens_venda iv ON iv.produto_id = p.id_produto
	group by f.nome)
    order by Porcentagem DESC;
