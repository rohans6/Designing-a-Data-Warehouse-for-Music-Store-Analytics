{{

    config(
        materialized='incremental',
        alias='dim_genre',
        schema=var('gold_schema'),
        unique_key = 'GenreId',
        incremental_strategy='delete+insert'
    )
}}

SELECT GenreId,Name FROM {{ref('stg_genre')}}