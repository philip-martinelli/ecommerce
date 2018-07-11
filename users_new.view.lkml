view: users_new {
  # sql_table_name: demo_db.users ;;
  derived_table: {
    sql:
    select * from users
    where
    {% assign var=_filters['users_new.state_filter'] %}
   {% if var == "" %}
  state = "California"
  {% else %}
  {% condition state_filter %} state {% endcondition %}
    {% endif %}
    ;;

    persist_for: "24 hours"
  }
  filter: state_filter {
    type: string
  }
  parameter: state_list {
    type: unquoted
#     allowed_value: {
#       label: "CA"
#       value: "California"
#     }
#     allowed_value: {
#       label: "OR"
#       value: "Oregon"
#     }
#     allowed_value: {
#       label: "Other"
#       value: "Other"
#     }
    }

    dimension: State_yesno_test {
      type: yesno
      sql:
          CASE WHEN {% parameter state_list %} = "California" THEN ${state} = "California"
                WHEN {% parameter state_list %} = "Oregon" THEN ${state} = "Oregon"
                ELSE ${state} != "California" AND ${state} != "Oregon" END
      ;;
    }

  dimension: State_yesno_test_string {
    type: string
    sql:
          CASE WHEN {% parameter state_list %} = "California" THEN ${state}
                WHEN {% parameter state_list %} = "Oregon" THEN ${state}
                ELSE ${state} != "California" AND ${state} != "Oregon" END
      ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    drill_fields: [state,city,gender]
  }
dimension: city_subtr {
  type: string
  sql: substring(${city},1,3) ;;
}
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
#     suggest_explore: new_users_pdt
#html: {{ users_new.city_subtr._value }} ;;
#     suggest_dimension: city
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  parameter: date_param {
    type: date
  }

  dimension: windows {
    type: string
    sql:
    case when ${created_date} >= (date_add({% parameter date_param %}, interval -28 day)) AND ${created_date} < date_add({% parameter date_param %},interval 1 day) then "window one"
    when ${created_date} < (date_add({% parameter date_param %}, interval -28 day)) AND ${created_date} >= (date_add({% parameter date_param %}, interval -56 day)) then "window two" end ;;
    convert_tz: no
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


  dimension: case_test_two {
    type: string
    sql: case when ${state} = 'California' then ${state} else ${city} ;;
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

  dimension: dynamic_dim {
    type: string
    sql:
    {% if users_new.sum_states._in_query %}
${state}
{% else %}
${zip}
{% endif %}
    ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    html:
    {% assign dynamic_domain = _user_attributes['domain'] | prepend: "https://" | append: "/explore/ecom/users_new" %}
    <a href="{{ dynamic_domain }}?fields=users_new.city&f[users_new.city]={{ _filters['users_new.city'] | url_encode }}" >{{value}}</a> ;;

  }

  #<a href={{ dynamic_domain }}>{{value}}</a> ;;
  #<%# {{dynamic_domain}} + Eval("?fields=users_new.city").ToString() %>

  dimension: orders_field {
    type: string
    sql: ${orders.id} ;;
  }

  dimension: state_yesno {
    type: yesno
    sql: {% condition state_filter %}  ${state} {% endcondition %} ;;
  }

  measure: sum_states {
    type: count
    value_format: "\" $ \" 0"
  }

  measure: sum_filtered_states {
    type: count
   filters: {
     field: state_yesno
    value: "yes"
   }
  }

  parameter: type {
    type: string
  }

  measure: count_a {
    type: count_distinct
    sql: ${id} ;;
    value_format: "0 \" format one\"" # Integer followed by a string (123 String)
    }
  measure: count_b {
    type: count_distinct
    sql: ${id};;
    value_format: "0 \" format two\"" # Integer followed by a string (123 String)
    }

  measure: count {
    type: number
    sql: case when  {% parameter type %} = "1" then ${count_a}
      else ${count_b} end;;
#     html: {{ _filters['users_new.type'] }} ;;
    html:
          {% if _filters['users_new.type'] == "1" %}
           {{ count_a._rendered_value }}
           {% else %}
           {{ count_b._rendered_value }}
           {% endif %}
     ;;
  }


#   parameter: type {
#     type: string
#   }
#
#   dimension: type_dim {
#     sql: {% parameter type %} ;;
#   }
#
#   measure: count_a {
#     type: count_distinct
#     sql: ${id} ;;
#     value_format: "0"
#   }
#   measure: count_b {
#     type: count_distinct
#     sql: ${id};;
#     value_format: "0.00/%"
#   }
#
#   measure: count {
#     type: number
#     sql: case when  {% parameter type %} = '1' then ${count_a}
#       else ${count_b} end;;
#
#     html: {% if users.type._value == "1" %}
#           {{ count_a._rendered_value }}
#           {% else %}
#           {{ count_b._rendered_value }}
#           {% endif %}
#     ;;
#   }
}
