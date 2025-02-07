{{

    config(
        materialized='incremental',
        alias='stg_invoiceline',
        schema=var('silver_schema'),
        unique_key = 'InvoiceLineId',
        incremental_strategy='delete+insert',
        primary_key = 'InvoiceLineId',
        distribution ='even'
    )
}}

SELECT InvoiceLineId,InvoiceId,TrackId,UnitPrice,Quantity FROM {{var('bronze_schema')}}.invoiceline