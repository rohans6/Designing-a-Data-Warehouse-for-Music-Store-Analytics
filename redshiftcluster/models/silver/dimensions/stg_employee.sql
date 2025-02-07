{{

    config(
        materialized='incremental',
        alias='stg_employee',
        schema=var('silver_schema'),
        unique_key = 'EmployeeId',
        incremental_strategy='delete+insert'
    )
}}

SELECT EmployeeId,LastName,FirstName,Title,ReportsTo,TO_TIMESTAMP(BirthDate,'DD-MM-YYYY') AS BirthDate,TO_TIMESTAMP(HireDate,'DD-MM-YYYY') AS HireDate,Address,City,State,Country,PostalCode,CAST(TRANSLATE(Phone,'+()- ','') AS BIGINT) AS Phone,CAST(TRANSLATE(Fax,'+()- ', '') AS BIGINT) AS Fax,Email FROM {{var('bronze_schema')}}.employee




