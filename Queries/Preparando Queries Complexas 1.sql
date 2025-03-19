-- Papel dos Fornecedores na Black Friday
SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes",f.nome as Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
GROUP BY Nome_Fornecedor, "Ano/Mes"
ORDER BY Nome_Fornecedor;
-- Categorias de produtos na black friday
SELECT strftime('%Y', v.data_venda) AS "Ano", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN categorias c ON c.id_categoria = p.categoria_id
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY Nome_Categoria, "Ano"
ORDER BY "Ano", Qtd_Vendas DESC;
