{{

    config(
        materialized='incremental',
        alias='dim_track',
        schema=var('gold_schema'),
        unique_key = 'TrackId',
        incremental_strategy='delete+insert'
    )
}}

SELECT TrackId,Name,AlbumId,MediaTypeId,GenreId,Composer,Milliseconds,Bytes,UnitPrice FROM {{ref('stg_track')}}