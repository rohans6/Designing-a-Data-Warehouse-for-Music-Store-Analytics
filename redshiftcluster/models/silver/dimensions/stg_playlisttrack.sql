{{

    config(
        materialized='incremental',
        alias='stg_playlisttrack',
        schema=var('silver_schema'),
        unique_key = 'PlaylistId',
        incremental_strategy='delete+insert'
    )
}}

SELECT PlaylistId,TrackId FROM {{var('bronze_schema')}}.playlisttrack
