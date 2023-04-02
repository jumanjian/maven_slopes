with final as(

    select *
    from {{ source('landing', 'resorts_maven') }}

)
 select * from final