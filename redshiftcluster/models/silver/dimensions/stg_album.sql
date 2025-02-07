{{

    config(
        materialized='incremental',
        alias='stg_album',
        schema=var('silver_schema'),
        unique_key = 'albumid',
        incremental_strategy='delete+insert'
    )
}}

SELECT albumid, title, artistid FROM {{var('bronze_schema')}}.album