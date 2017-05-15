view: users_test {
  derived_table: {
    sql:select id,state
    from users
    where {% condition state_filter %} state {% endcondition %};;
    sql_trigger_value: SELECT 1;;
    indexes: ["state"]
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
  }

  filter: state_filter {
    type: string
    default_value: "California"
  }
}