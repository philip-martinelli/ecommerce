view: users_pdt_scratch_schem_test {

  derived_table: {
    sql:
    SELECT state, gender FROM demo_db.users
    where date(created_at) >= (case when {% parameter date_param %} is null then  '2016-01-01' else {% parameter date_param %} end)  ;;
    persist_for: "1 hour"
  }

  parameter: date_param {
    type: date
    #
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
#
#   dimension: age {
#     type: number
#     sql: ${TABLE}.age ;;
#   }
#
#   dimension: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }
#
#   dimension: country {
#     type: string
#     sql: ${TABLE}.country ;;
#   }
#
#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }
#
#   dimension: email {
#     type: string
#     sql: ${TABLE}.email ;;
#   }
#
#   dimension: first_name {
#     type: string
#     sql: ${TABLE}.first_name ;;
#   }
#
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
#
#   dimension: last_name {
#     type: string
#     sql: ${TABLE}.last_name ;;
#   }
#
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
#
#   dimension: zip {
#     type: number
#     sql: ${TABLE}.zip ;;
#   }
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
