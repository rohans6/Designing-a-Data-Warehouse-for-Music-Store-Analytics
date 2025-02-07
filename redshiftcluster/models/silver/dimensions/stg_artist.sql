{{

    config(
        materialized='incremental',
        alias='stg_artist',
        schema=var('silver_schema'),
        unique_key = 'artistid',
        incremental_strategy='delete+insert'
    )
}}

SELECT artistid,name FROM {{var('bronze_schema')}}.artist