view: max_date_dt {
  derived_table: {
    sql:
      SELECT max(created_at) as max_date FROM demo_db.orders limit 1;;
  }
  dimension_group: max_date {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.max_date ;;
  }
}
