{{

    config(
        materialized='incremental',
        alias='dim_playlist',
        schema=var('gold_schema'),
        unique_key = 'PlaylistId',
        incremental_strategy='delete+insert'
    )
}}

SELECT PlaylistId,Name FROM {{ref('stg_playlist')}}