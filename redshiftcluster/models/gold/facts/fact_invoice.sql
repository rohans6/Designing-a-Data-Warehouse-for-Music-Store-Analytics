{{ config(
    materialized='incremental',
    alias='fact_invoice',
    schema=var('gold_schema'),
    unique_key='InvoiceId',
    incremental_strategy='delete+insert',
    primary_key='InvoiceId',
    distribution='even'
) }}

WITH invoice AS (
    -- Get base invoice data
    SELECT 
        InvoiceId,
        CustomerId,
        TO_TIMESTAMP(invoiceDate, 'YYYY-MM-DD') AS invoiceDate,
        BillingAddress,
        BillingCity,
        BillingState,
        BillingCountry,
        BillingPostalCode,
        Total
    FROM {{ ref('stg_invoice') }}
),

invoiceline AS (
    -- Aggregate total quantity and total bytes by InvoiceId
    SELECT 
        il.InvoiceId,
        SUM(il.Quantity) AS TotalQuantity,
        SUM(t.Bytes) AS TotalBytes
    FROM {{ ref('stg_invoiceline') }} il
    LEFT JOIN {{ ref('stg_track') }} t ON il.TrackId = t.TrackId
    GROUP BY il.InvoiceId
)

SELECT 
    i.InvoiceId,
    i.CustomerId,
    i.invoiceDate,
    i.BillingAddress,
    i.BillingCity,
    i.BillingState,
    i.BillingCountry,
    i.BillingPostalCode,
    i.Total,
    COALESCE(il.TotalQuantity, 0) AS TotalQuantity,
    COALESCE(il.TotalBytes, 0) AS TotalBytes
FROM invoice i
LEFT JOIN invoiceline il ON i.InvoiceId = il.InvoiceId
