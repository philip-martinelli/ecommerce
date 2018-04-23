view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: sum_sale {
    label: "sum of all orders"
    type: sum
    sql: ${sale_price} ;;
    value_format: "$#,##0.00"
  }

measure: sum_sale_first_orders {
  label: "sum of first purchase month orders"
  description: "sum of orders whose first time purchase is the selected month"
  type: sum
  sql: ${sale_price};;
  value_format: "$#,##0.00"
  filters: {
    field:orders.first_order_in_created_month
    value: "yes"
  }
}

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }
}
