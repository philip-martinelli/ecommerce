view: users_new {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    suggest_explore: new_users_pdt
    suggest_dimension: city
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    suggest_explore: new_users_pdt
    suggest_dimension: state
    suggest_persist_for: "10 seconds"
  }

  dimension: state_case {
    case: {
      when: {
        label: "California"
        sql: ${TABLE}.state = "California" OR ${TABLE}.state = "Oregon" ;;
      }
      when: {
        label: "New York"
        sql: ${TABLE}.state = "New York" ;;
      }
      else: "Other"
    }
  }

  dimension: city_case {
    case: {
      when: {
        label: "San Jose"
        sql: ${TABLE}.city = "San Jose" ;;
      }
      when: {
        label: "Yonkers"
        sql: ${TABLE}.state = "Yonkers" ;;
      }
      else: "Other"
    }
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name]
  }
}
