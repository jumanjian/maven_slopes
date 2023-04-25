with final as (
    select * from {{ source('landing', 'snow_maven') }}
)

select * from final