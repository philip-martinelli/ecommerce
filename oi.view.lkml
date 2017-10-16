view: oi {
  derived_table: {
    sql:
    SELECT * FROM ${orders.SQL_TABLE_NAME}
    WHERE ${orders.SQL_TABLE_NAME}.status = 'pending'


    ;;
  }



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
    sql: (0 - ${TABLE}.order_id) ;;
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
    type: sum
    sql: (0 - ${sale_price}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }


  }
