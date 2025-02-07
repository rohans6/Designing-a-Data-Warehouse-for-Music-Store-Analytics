{{

    config(
        materialized='incremental',
        alias='stg_invoice',
        schema=var('silver_schema'),
        unique_key = 'InvoiceId',
        incremental_strategy='delete+insert',
        primary_key = 'InvoiceId',
        distribution ='even'
    )
}}



SELECT InvoiceId,CustomerId,TO_TIMESTAMP(invoiceDate,'DD-MM-YYYY') AS invoiceDate,BillingAddress,BillingCity,BillingState,BillingCountry,BillingPostalCode,Total FROM {{var('bronze_schema')}}.invoice