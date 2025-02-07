{{

    config(
        materialized='incremental',
        alias='stg_track',
        schema=var('silver_schema'),
        unique_key = 'TrackId',
        incremental_strategy='delete+insert'
    )
}}

SELECT TrackId,Name,AlbumId,MediaTypeId,GenreId,Composer,Milliseconds,Bytes,UnitPrice FROM {{var('bronze_schema')}}.track
