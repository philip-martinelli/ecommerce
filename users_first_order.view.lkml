view: users_plus_first_order_dt {
  derived_table: {
    sql: select
      *
      ,(select min(o.created_at) from orders o where o.user_id = users.id) as first_order_dt
      from users
       ;;
  }

  measure: count {
    type: count
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: created_at {
    type: string
    sql: ${TABLE}.created_at ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

  dimension_group: first_order_dt {
    type: time
    timeframes: [month,date]
    sql: ${TABLE}.first_order_dt ;;
  }
  measure: sum_sale_for_month{
    type: number
    sql:
    (select sum(oi.sale_price) from users u join orders o on u.id = o.user_id join order_items oi on oi.order_id = o.id where DATE_FORMAT(o.created_at,'%Y-%m-01') = DATE_FORMAT(users_plus_first_order_dt.first_order_dt,'%Y-%m-01'))
    ;;
  }


}
