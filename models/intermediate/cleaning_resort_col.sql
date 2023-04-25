with raw as (
    select * from {{ ref('stg_resorts') }}
),

replace_func as(
    select ID as ID_resort, REPLACE(Resort, '?', '') AS Resort_c
    from raw
    where Resort LIKE '%?%'
),

final  as(
    select *
    from raw
    join replace_func
    on raw.ID = replace_func.ID_resort
)

select * from final
