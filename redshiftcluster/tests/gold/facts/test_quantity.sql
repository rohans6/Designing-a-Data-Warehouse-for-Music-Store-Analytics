SELECT InvoiceId 
FROM {{ref('fact_invoice')}}
WHERE TotalQuantity<0