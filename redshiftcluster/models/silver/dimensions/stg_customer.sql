{{

    config(
        materialized='incremental',
        alias='stg_customer',
        schema=var('silver_schema'),
        unique_key = 'CustomerId',
        incremental_strategy='delete+insert'
    )
}}

SELECT CustomerId,FirstName,LastName,Company,Address,City,State,Country,PostalCode,Phone,Fax,Email,SupportRepId FROM {{var('bronze_schema')}}.customer


