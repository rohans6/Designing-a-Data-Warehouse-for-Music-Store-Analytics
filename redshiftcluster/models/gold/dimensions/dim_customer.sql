{{

    config(
        materialized='incremental',
        alias='dim_customer',
        schema=var('gold_schema'),
        unique_key = 'CustomerId',
        incremental_strategy='delete+insert'
    )
}}

SELECT CustomerId,FirstName,LastName,Company,City,Country,SupportRepId FROM {{ref('stg_customer')}}


