with raw as(
    select * from {{ref("cleaning_resort_col")}}
),
split_seasons as(
    select *,
    SPLIT(season, ',')[OFFSET(0)] as season1,
    CASE 
        WHEN ARRAY_LENGTH(SPLIT(season, ',')) >= 2 THEN SPLIT(season, ',')[OFFSET(1)] 
        ELSE NULL 
    END as season2,
    CASE 
        WHEN ARRAY_LENGTH(SPLIT(season, ',')) >= 3 THEN SPLIT(season, ',')[OFFSET(2)] 
        ELSE NULL 
    END as season3
    from raw
), 
pivot_seasons as (
    select *
    from split_seasons
    UNPIVOT (
        value FOR column_name IN (season1,season2, season3)
        )
),
final as (
    select ID, Resort_c as Resorts, Latitude, Longitude, Country, Continent, Price, Value as Seasons, Highest_point, Lowest_point, Beginner_slopes, Intermediate_slopes, Difficult_slopes, Total_slopes, Longest_run, Snow_cannons, Surface_lifts, Chair_lifts, Gondola_lifts, Total_lifts, Lift_capacity, Child_friendly, Snowparks, Nightskiing, Summer_skiing
    from pivot_seasons
)
select * from final