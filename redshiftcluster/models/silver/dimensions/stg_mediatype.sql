{{

    config(
        materialized='incremental',
        alias='stg_mediatype',
        schema=var('silver_schema'),
        unique_key = 'MediaTypeId',
        incremental_strategy='delete+insert'
    )
}}

SELECT MediaTypeId,Name FROM {{var('bronze_schema')}}.mediatype



