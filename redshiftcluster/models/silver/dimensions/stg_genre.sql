{{

    config(
        materialized='incremental',
        alias='stg_genre',
        schema=var('silver_schema'),
        unique_key = 'GenreId',
        incremental_strategy='delete+insert'
    )
}}

SELECT GenreId,Name FROM {{var('bronze_schema')}}.genre


