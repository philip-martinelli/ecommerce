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
    type: string
    allowed_value: {
      label: "CA"
      value: "California"
    }
    allowed_value: {
      label: "OR"
      value: "Oregon"
    }
    allowed_value: {
      label: "Other"
      value: "Other"
    }
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
  }

  dimension: city {
    view_label: "Orders Test"
    group_label: "Group Label"
    type: string
    sql: ${TABLE}.city ;;
    suggest_explore: new_users_pdt
    suggest_dimension: city
  }

  dimension: country {
    view_label: "Orders Test"
    group_label: "Group Label"
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
    view_label: "Orders Test"
    group_label: "Group Label"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

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
  }

  measure: sum_filtered_states {
    type: count
   filters: {
     field: state_yesno
    value: "yes"
   }
  }

  dimension: dummy_yesno {
    type: yesno
    sql:
        EXISTS (select u.id from users as u where u.id = users_new.id and u.state = "California")

        AND

        EXISTS (select u.id from users as u where u.id= users_new.id and date_format(u.created_at,"%Y") = "2017")

    ;;



  }
}
