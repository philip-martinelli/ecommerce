view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  filter: test_f {
    type: string
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    drill_fields: [orders.id]
    order_by_field: city_sort
    #map_layer_name: state_layer
  }

  dimension: city_sort {
    type: string
    hidden: yes
    sql:
    case when
            ${city} = "San Jose" then "a"
            when ${city} = "Los Angeles" then "b"
            when ${city} = "Atlanta" then "c"

            end
    ;;
  }

  measure: max_date {
    type: date
    sql: max(${created_raw}) ;;
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
    html:
    {% if value == 'm' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'f' %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    }

  dimension: has_order {
    type: yesno
    sql:
        EXISTS(
                SELECT o.id from orders as o WHERE users.id = o.user_id
              )
    ;;
  }


  dimension: t {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
   # map_layer_name: zip_layer
  }

  measure: count_regular {
    type: count
    drill_fields: [advanced*]
  }

  measure: count_users_with_orders {
    type: count
    filters: {
      field: has_order
      value: "yes"
    }
  }

  measure: count_users_without_orders {
    type: count
    filters: {
      field: has_order
      value: "no"
    }
  }

  dimension: state_test {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: test {
    type: number
    sql: ${count_users_with_orders}/${zip} ;;
  }

  measure: all_users {
    drill_fields: [last_name]
    type: number
    sql: ${count_users_with_orders} + ${count_users_without_orders} ;;
    link: {
      label: "pivot test-explore"
      url: "https://self-signed.looker.com:9999/explore/ecommerce/users?fields=users.state,users.count_users_with_orders&f[users.gender]={{ users.gender._filterable_value}}"
    }
  }

set: basic {
  fields: [id,age,state]
}
set: advanced {
  fields: [city,created_date,count_regular]
}

dimension: grouped_state_rename {
  type: string
  sql: CASE WHEN {% condition test_f %} ${state} {% endcondition %} THEN "CA" else "OTHER" end;;
}


}
