/*
Chegou a hora de se desafiar a desenvolver ainda mais todo o conhecimento aprendido durante nossa jornada!
Aqui estão algumas atividades que vão te ajudar a praticar e fixar ainda mais cada conteúdo e caso você precise de ajuda, 
opções de solução das atividades estão disponíveis na seção “Opinião da pessoa instrutora”.
*/
--#1
SELECT COUNT(id_cliente) from clientes;
--#2
SELECT COUNT(id_produto) from produtos;
--#3
SELECT c.nome_categoria, count(iv.venda_id) as Vendas_Categoria FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
GROUP BY c.nome_categoria;
--#4
SELECT MIN(strftime('%Y',data_venda)) AS Primeiro_Ano FROM vendas;
--#5
SELECT nome, MAX(Max_Vendas) FROM 
(SELECT f.nome, COUNT(iv.venda_id) AS Max_Vendas FROM fornecedores f
JOIN produtos p on f.id_fornecedor = p.fornecedor_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
GROUP BY f.nome
);
--#6
SELECT nome, MAX(Max_Vendas) FROM 
(SELECT f.nome, COUNT(iv.venda_id) AS Max_Vendas, strftime('%Y',data_venda) AS Ano FROM fornecedores f
JOIN produtos p on f.id_fornecedor = p.fornecedor_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY f.nome, Ano
HAVING Ano = '2020'
);
--#7
SELECT nome_categoria, Top_Vendas FROM
(SELECT c.nome_categoria, COUNT(iv.venda_id) AS Top_Vendas FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
ORDER BY Top_Vendas DESC) LIMIT 2;
--#8
SELECT 
    strftime('%Y/%m', v.data_venda) AS Ano_mes, 
    --Definindo um A soma de todas as incidencias de um CASE em momentos onde temos a apariação do nome 'Alimentos' OU 'Eletrônicos'
    SUM(CASE WHEN c.nome_categoria = 'Alimentos' THEN 1 ELSE 0 END) AS Vendas_Alimentosas,
    SUM(CASE WHEN c.nome_categoria = 'Eletrônicos' THEN 1 ELSE 0 END) AS Vendas_Eletronicos
FROM vendas v
JOIN itens_venda iv ON v.id_venda = iv.venda_id
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN categorias c ON p.categoria_id = c.id_categoria
GROUP BY Ano_mes
ORDER BY Ano_mes ASC;
--#9
SELECT c.nome_categoria, COUNT(iv.venda_id) AS Top_Vendas , ROUND(100.0*COUNT(iv.venda_id)/(SELECT COUNT(*) From itens_venda), 2) as Porcentagem 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
;
--#10
SELECT (SELECT max(Top_Vendas) FROM 
(SELECT COUNT(iv.venda_id) AS Top_Vendas 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
))
-
(SELECT min(Top_Vendas) FROM 
(SELECT COUNT(iv.venda_id) AS Top_Vendas 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
)) AS Diferenca_Vendas,
(SELECT max(Porcentagem) FROM 
(SELECT ROUND(100.0*COUNT(iv.venda_id)/(SELECT COUNT(*) From itens_venda), 2) as Porcentagem 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
))
-
(SELECT min(Porcentagem) FROM 
(SELECT ROUND(100.0*COUNT(iv.venda_id)/(SELECT COUNT(*) From itens_venda), 2) as Porcentagem 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
)) AS Diferenca_Porcentagem
FROM 
(SELECT COUNT(iv.venda_id) AS Top_Vendas 
FROM categorias c
JOIN produtos p on c.id_categoria = p.categoria_id
JOIN itens_venda iv ON p.id_produto = iv.produto_id
JOIN vendas v ON v.id_venda = iv.venda_id
GROUP BY c.nome_categoria
) GROUP BY Diferenca_Vendas, Diferenca_Porcentagem;

