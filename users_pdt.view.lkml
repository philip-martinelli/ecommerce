view: users_pdt_scratch_schem_test {

  derived_table: {
    sql:
    SELECT sum(id) FROM ${users_new.SQL_TABLE_NAME};;
  }

#
  measure: count {
    type: count
  }
#
#   # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       id,
#       last_name,
#       first_name,
#       events.count,
#       orders.count,
#       user_data.count
#     ]
#   }
}
