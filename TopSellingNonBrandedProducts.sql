SELECT TOP (100)
    ol.orl_productId,
    ol.orl_productName,
    ol.orl_productSku,
    SUM(ol.orl_quantity) AS Total_Purchased,
    p.prd_id,
    p.prd_brandId
FROM dbo.tblOrderLine ol
JOIN dbo.tblProduct p
    ON ol.orl_productId = p.prd_id
WHERE p.prd_brandId NOT IN (104, 109, 155, 160, 182, 207, 211, 212, 225)
GROUP BY
    ol.orl_productId,
    ol.orl_productName,
    ol.orl_productSku,
    p.prd_id,
    p.prd_brandId
ORDER BY
    SUM(ol.orl_quantity) DESC;
