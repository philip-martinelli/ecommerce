#include: "ecom.model"
view: users_facts {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
    select
     a.user_id
    ,count(a.id)
    ,MIN(a.created_at) as earliest_purchase_date
    ,MAX(a.created_at) as most_recent_purchase_date
    ,DATEDIFF(MAX(a.created_at),MIN(a.created_at)) as days_between_earliest_and_most_recent_purchase_date
    ,count(a.id)/(select TIMESTAMPDIFF(MONTH,MIN(b.created_at),NOW()) as months_since_first_purchase
    from orders b
    where b.user_id = a.user_id
    group by b.user_id) as avg_orders_per_months_as_customer
    from orders a
    where a.created_at is not null
    group by 1
    ;;
    persist_for: "1 hour"
    indexes: ["user_id"]
  }
  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: most_recent_purchase {
    description: "The date when each user last ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.most_recent_purchase_date ;;
  }

  dimension_group: earliest_purchase {
    description: "The date when each user last ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.earliest_purchase_date ;;
  }

  dimension: diff {
    type: number
    sql: ${TABLE}.diff;;
  }

  dimension: repeat_customer {
    type: yesno
    sql: ${TABLE}.diff >= 1;;
  }

  dimension: average_orders_per_month {
    type: number
    sql: ROUND(${TABLE}.avg_orders_per_months_as_customer,2) ;;
  }

  dimension: average_orders_per_month_tiered {
    type: tier
    style: interval
    tiers: [0.04,0.06,0.08,1.0]
    sql: ${TABLE}.avg_orders_per_months_as_customer ;;
  }

  dimension: date_diff {
    type: number
    sql: DATEDIFF(DATE(${TABLE}.most_recent_purchase_at),DATE(${TABLE}.earliest_purchase_at )) ;;
    label: "Max/Min Diff"
  }

  measure: count {
    type: count
    drill_fields: []
  }

#   measure: date_diff_av {
#     type: average
#     sql: ${date_diff} ;;
#   }

#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
