SELECT DISTINCT --TOP(10000)
    o.ord_id AS [Order ID],
    o.ord_invoicetaxDate AS [Tax Date],
    o.ord_net AS [Net],
    o.ord_total AS [Total],
    o.ord_channelId AS [Channel Id],
    ord_orderTypeCode AS [Type Code],
    ol.orl_id AS [Orderline ID],
    ol.orl_productId AS [Product Id],
    ol.orl_productSku AS [Product SKU],
    ol.orl_productName AS [Product Name],
    ol.orl_quantity AS [Quantity],    
    CASE 
        WHEN ol.orl_compositionBundleParent = 1 THEN op.bpar_orl_calcRowNetValue
        WHEN ol.orl_compositionBundleChild = 1 THEN oc.bchd_orl_calcRowNetValue
        ELSE ol.orl_rowNetValue
    END AS [Product Value],
    CASE 
        WHEN ol.orl_compositionBundleParent = 1 THEN op.bpar_orl_calcRowTaxValue
        WHEN ol.orl_compositionBundleChild = 1 THEN oc.bchd_orl_calcRowTaxValue
        ELSE ol.orl_rowTaxValue
    END AS [Product Tax Value],
    ol.orl_productPriceValue AS [Price of Product],
    CASE 
        WHEN ol.orl_compositionBundleParent = 1 THEN op.bpar_orl_itemCostValue
        WHEN ol.orl_compositionBundleChild = 1 THEN oc.bchd_orl_itemCostValue
        ELSE ol.orl_itemCostValue
    END AS [Cost of Product],
    ol.orl_nominalCode AS [Nominal Code]
FROM dbo.tblOrder AS o
LEFT JOIN dbo.tblOrderLine AS ol ON o.ord_id = ol.orl_ord_id
LEFT JOIN Perceptium.tblOrderLineParentView AS op ON ol.orl_id = op.bpar_orl_id
LEFT JOIN Perceptium.tblOrderLineChildView AS oc ON ol.orl_id = oc.bchd_orl_id
WHERE ol.orl_productSku IN ('S48', 'CCBL595WH/', 'AMSTERDAM15-BS')
/*
SELECT DISTINCT
    o.ord_id AS [Order ID],
    o.ord_invoicetaxDate AS [Tax Date],
    o.ord_net AS [Net],
    o.ord_total AS [Total],
    o.ord_channelId AS [Channel Id],
    ord_orderTypeCode AS [Type Code],
    ol.orl_id AS [Orderline ID],
    ol.orl_productId AS [Product Id],
    ol.orl_productSku AS [Product SKU],
    ol.orl_productName AS [Product Name],
    ol.orl_quantity AS [Quantity],
    ol.orl_rowNetValue AS [Product Value],
    ol.orl_rowTaxValue AS [Product Tax Value],
    ol.orl_productPriceValue AS [Price of Product],
    ol.orl_itemCostValue AS [Cost of Product],
    ol.orl_nominalCode AS [Nominal Code]
FROM dbo.tblOrder AS o
LEFT JOIN dbo.tblOrderLine AS ol ON o.ord_id = ol.orl_ord_id
WHERE o.ord_invoicetaxDate >= '2020-01-01'
*/