{{

    config(
        materialized='incremental',
        alias='stg_playlist',
        schema=var('silver_schema'),
        unique_key = 'PlaylistId',
        incremental_strategy='delete+insert'
    )
}}

SELECT PlaylistId,Name FROM {{var('bronze_schema')}}.playlist
