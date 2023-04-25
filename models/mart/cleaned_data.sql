with final as(
    select * from {{ref("cleaning_season_col")}}
)

select * from final