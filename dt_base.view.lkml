view: dt_base {
 derived_table: {
   sql:
      SELECT * FROM users limit 10
  ;;
 }

dimension: id {
  sql: ${TABLE}.id ;;
}

}
