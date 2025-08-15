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