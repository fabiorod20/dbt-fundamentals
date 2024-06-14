with payments as (

    select * from {{ ref('stg_stripe__payments') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

order_payment as (

    select 
        order_id,
        sum (case when status = 'success' then amount end) as amount 
    
    from payments
    group by 1

),

join_orders as (

    select
        orders.order_id
        , orders.customer_id
        , orders.order_date
        , coalesce (order_payment.amount, 0) as amount

    from orders left join order_payment using (order_id)
)

select * from join_orders