view: orders {
sql_table_name: demo_db.orders ;;

#   derived_table: {
#     sql: SELECT * FROM  demo_db.orders
# --       Group by 1
#  --     HAVING {% condition num_filter %} order_count {% endcondition %}
#
#       ;;
#
#     }

    filter: check_one {
      type: string
      sql: ${status} = LEFT(REPLACE({% parameter check_one %},"-",""),6);;
      #CONCAT(LEFT(REPLACE('2017-07-07',"-",""),6),"%")
    }

#     filter: check_two {
#       sql: ${id} = "{{ _filters['orders.check_one'] }}" ;;
#     }

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
      day_of_month,
      day_of_week
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
    label: "userszzzz_id"
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

#   dimension: inventory_item_id_test {
#     type: string
#     sql: ${order_items.inventory_item_id} ;;
#   }

  measure: count {
    type: count
    drill_fields: [id,order_items.count]
  }

  measure: count_test {
    type: count
   # sql: ${id} ;;
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


#   dimension: in_last_12_month {
#     type: yesno
#     sql:  ${created_date} >= DATE_ADD(date_format(${max_date_dt.max_date_raw},'%Y-%m-01'), INTERVAL -12 MONTH)
#     ;;
#   }


}
