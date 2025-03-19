SELECT DISTINCT(strftime('%Y',data_venda)) AS Ano from vendas
order by Ano;

SELECT strftime('%Y', data_venda) AS Ano, COUNT(id_venda) as Total_Vendas
FROM vendas
GROUP BY Ano
ORDER BY Ano;

SELECT strftime('%Y', data_venda) AS Ano, strftime('%m', data_venda) As Mes, COUNT(id_venda) as Total_Vendas
FROM vendas
GROUP BY Ano, Mes
ORDER BY Ano;

SELECT strftime('%Y', data_venda) AS Ano, strftime('%m', data_venda) As Mes, COUNT(id_venda) as Total_Vendas
FROM vendas
WHERE Mes = '01' OR Mes = '11' OR Mes = '12'
GROUP BY Ano, Mes
ORDER BY Ano;
