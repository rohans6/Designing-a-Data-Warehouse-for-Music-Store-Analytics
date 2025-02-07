{{

    config(
        materialized='incremental',
        alias='dim_playlisttrack',
        schema=var('gold_schema'),
        unique_key = 'PlaylistId',
        incremental_strategy='delete+insert'
    )
}}

SELECT PlaylistId,TrackId FROM {{ref('stg_playlisttrack')}}
