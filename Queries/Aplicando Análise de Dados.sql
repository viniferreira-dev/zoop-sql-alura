-- Papel dos fornecedores na Black Friday
SELECT SUM(Qtd_Vendas)
FROM (
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  GROUP BY Nome_Fornecedor, "Ano/Mes"
  ORDER BY "Ano/Mes", Qtd_Vendas
);

-- Categorias de produtos na Black Friday
SELECT strftime('%Y', v.data_venda) AS "Ano", c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN categorias c ON c.id_categoria = p.categoria_id
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY Nome_Categoria, "Ano"
ORDER BY "Ano", Qtd_Vendas DESC;

-- Vendas por fornecedor específico
SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
 --DEFINE SOMENTE O FORNECEDOR QUE TEVE MAIOR NUMERO DE VENDAS, COMO VIMOS NA QUERY "Papel dos fornecedores na Black Friday"
WHERE f.nome = 'NebulaNetworks'
GROUP BY f.nome, "Ano/Mes"
ORDER BY "Ano/Mes", Qtd_Vendas;

-- Vendas por múltiplos fornecedores específicos
SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
WHERE f.nome IN ('NebulaNetworks', 'HorizonDistributors', 'AstroSupply')
GROUP BY Nome_Fornecedor, "Ano/Mes"
ORDER BY "Ano/Mes", Qtd_Vendas;

-- Vendas mensais agregadas por fornecedor
SELECT "Ano/Mes",
  --CRIA AS COLUNAS PARA CADA FORNCEDOR
  SUM(CASE WHEN Nome_Fornecedor = 'NebulaNetworks' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_NebulaNetworks,
  SUM(CASE WHEN Nome_Fornecedor = 'HorizonDistributors' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_HorizonDistributors,
  SUM(CASE WHEN Nome_Fornecedor = 'AstroSupply' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_AstroSupply
FROM (
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN fornecedores f ON f.id_fornecedor = p.fornecedor_id
  WHERE f.nome IN ('NebulaNetworks', 'HorizonDistributors', 'AstroSupply')
  GROUP BY Nome_Fornecedor, "Ano/Mes"
  ORDER BY "Ano/Mes", Qtd_Vendas
)
GROUP BY "Ano/Mes";

-- Porcentagem das Categorias
SELECT COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv;

-- Contagem de vendas por categoria
SELECT c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON v.id_venda = iv.venda_id
JOIN produtos p ON p.id_produto = iv.produto_id
JOIN categorias c ON c.id_categoria = p.categoria_id
GROUP BY Nome_Categoria
ORDER BY Qtd_Vendas DESC;

-- Porcentagem de vendas por categoria
SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0 * Qtd_Vendas / (SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM (
  SELECT c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN produtos p ON p.id_produto = iv.produto_id
  JOIN categorias c ON c.id_categoria = p.categoria_id
  GROUP BY Nome_Categoria
  ORDER BY Qtd_Vendas DESC
);
