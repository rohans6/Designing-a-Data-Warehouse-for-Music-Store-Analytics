{{

    config(
        materialized='incremental',
        alias='dim_employee',
        schema=var('gold_schema'),
        unique_key = 'EmployeeId',
        incremental_strategy='delete+insert'
    )
}}

SELECT EmployeeId,LastName,FirstName,Title,ReportsTo,TO_TIMESTAMP(BirthDate, 'DD-MM-YYYY'),City,State,Country FROM {{ref('stg_employee')}}
