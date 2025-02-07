{{

    config(
        materialized='incremental',
        alias='dim_artist',
        schema=var('gold_schema'),
        unique_key = 'artistid',
        incremental_strategy='delete+insert'
    )
}}

SELECT artistid,name FROM {{ref('stg_artist')}}