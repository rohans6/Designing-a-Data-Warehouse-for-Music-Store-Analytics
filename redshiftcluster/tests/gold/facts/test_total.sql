SELECT InvoiceId 
FROM {{ref('fact_invoice')}}
WHERE Total<0