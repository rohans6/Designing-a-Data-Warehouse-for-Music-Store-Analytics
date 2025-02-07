{{

    config(
        materialized='incremental',
        alias='dim_mediatype',
        schema=var('gold_schema'),
        unique_key = 'MediaTypeId',
        incremental_strategy='delete+insert'
    )
}}

SELECT MediaTypeId,Name FROM {{ref('stg_mediatype')}}
