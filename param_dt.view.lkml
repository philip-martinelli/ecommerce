view: param_dt {
  sql_table_name: users ;;
#   derived_table: {
#     sql:
#         WITH state as (
#                       SELECT
#                       state as state
#                       ,COUNT(*) as count
#                       FROM users
#                       GROUP BY 1)

#             ,month as (
#                       SELECT
#                       created_at as month
#                       ,COUNT(*) as count
#                       FROM users
#                       GROUP BY 1)



#         SELECT
#         *
#         FROM {% parameter dt_select %}
#     ;;
#   }

#   parameter: dt_select {
#     type: unquoted
#     allowed_value: {
#       label: "state"
#       value: "state"
#     }
#     allowed_value: {
#       label: "month"
#       value: "month"
#     }
#   }


#   dimension: dt_select_field {
#     type: string
#     sql: ${TABLE}.dt_select_field ;;
#   }

#   dimension: count  {
#     type: number
#     sql: ${TABLE}.count  ;;
#   }




# }
  parameter: dt_select {
    type: string
    }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    label:"{% parameter dt_select %}"
  }



}
