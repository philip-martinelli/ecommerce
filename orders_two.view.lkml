view: orders_two {
 sql_table_name: demo_db.orders ;;

#    derived_table: {
#     persist_for: "24 hours"
#      sql: SELECT * FROM  demo_db.orders
#           WHERE {% condition date_filter %} created_at {% endcondition %}
#        ;;
#      }

  filter: date_filter {
    type: date
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_d {
    type: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_two {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: inventory_item_id_test {
    type: string
    sql: ${order_items.inventory_item_id} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }

  measure: count_test {
    type: count
  #  sql: ${id} ;;
    filters: {
      field: created_date
      value: "1 month ago"
    }
  }

  filter: last_one_day_filter {
    type: date_time
  }

  dimension: last_one_day {
    type: yesno
    sql: {% condition last_one_day_filter %} ${created_raw} {% endcondition %} ;;
  }

  measure: count_last_one_day {
    type: count
    filters: {
      field: last_one_day
      value: "yes"
    }
  }

  dimension: yesnotest{
    type: yesno
    sql: {% condition userid_plus_one %} user_id + 1 {% endcondition %};;
  }

  filter: userid_plus_one {
    type: number
  }

}
