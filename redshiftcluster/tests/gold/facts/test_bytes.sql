SELECT InvoiceId 
FROM {{ref('fact_invoice')}}
WHERE TotalBytes<0