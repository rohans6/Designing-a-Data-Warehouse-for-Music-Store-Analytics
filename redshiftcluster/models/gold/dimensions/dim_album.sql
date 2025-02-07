{{

    config(
        materialized='incremental',
        alias='dim_album',
        schema=var('gold_schema'),
        unique_key = 'albumid',
        incremental_strategy='delete+insert'
    )
}}

SELECT albumid, title, artistid FROM {{ref('stg_album')}}