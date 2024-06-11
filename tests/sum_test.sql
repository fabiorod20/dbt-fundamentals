with ltv as(
    select * from {{ ref('dim_customers')}}
)

select
    sum(lifetime_value) as total_ltv
from
    ltv
having
    total_ltv <> 1672