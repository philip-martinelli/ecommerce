view: users {
  sql_table_name: demo_db.users ;;

  filter: test_filter {
    type: string
  }

  dimension: test_dim {
    type: number
    sql: ${TABLE}.id/1/2/(case when "{% parameter param_exampe %}" = "State" then 3 else 4 end);;
  }
  dimension: case_test_two {
    type: string
    sql: case when ${state} = 'California' then ${state} else ${city} end ;;
  }
  dimension: test_dim_test {
    type: number
    sql: ${TABLE}.id/1/2/3 ;;
  }
  filter: state_f {}

  dimension: abc {
    type: string
    sql:
    case when {% condition state_f %} 'California' {% endcondition  %} then ${city}
        when {% condition state_f %} 'Oregon' {% endcondition  %} then ${city}
        when {% condition state_f %} 'Washington' {% endcondition  %} then ${city}
        else null end
    ;;
  }

  dimension: dynamic_column {
    type: string
    sql: ${TABLE}.{% parameter param_exampe %} ;;
  }

  parameter: param_exampe {
    type: number
  }

  measure: param_meas {
    type: number
    sql: (select id from users where id/{% parameter param_exampe %} = 30) ;;
  }

  parameter: param_example {
    type: unquoted
    allowed_value: {
      label: "California"
      value: "California"
    }
    allowed_value: {
      label: "New York"
      value: "New_York"
    }
    allowed_value: {
      label: "New Mexico"
      value: "New_Mexico"
    }
    allowed_value: {
      label: "All States"
      value: "All_states"
    }
  }

  dimension: Boolean_field_for_state {
    type: yesno
    sql: CASE WHEN '{% parameter param_example %}' = 'California' THEN ${TABLE}.state = 'California'
              WHEN '{% parameter param_example %}' = 'New_York' THEN ${TABLE}.state = 'New York'
              WHEN '{% parameter param_example %}' = 'New_Mexico' THEN ${TABLE}.state = 'New Mexico'
              ELSE 1=1 end;;
  }


  filter: user_date_filter {
    type: date
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;

  }

  dimension: exists_corr_sq {
    type: string
    sql: CASE WHEN EXISTS (SELECT o.user_id FROM orders o WHERE o.user_id = users.id) THEN "Has Order" ELSE "Doesn't"  END ;;
  }

  filter: is_ca_filter {
    type: yesno
  }

  dimension: is_ca {
    type: yesno
    #sql: ${state} = {% parameter users.state_param %} ;;
    sql: ${state} = "California" ;;

  }

  # '{{ _user_attributes['state'] }}'

  measure: max_date_w_filters_one {
    type: date
    sql: max(CASE WHEN ${state} = 'California' then ${created_date} else null end) ;;
  }


#sql: ${state} = "{{ _user_attributes['state'] }}" ;;


  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    can_filter: no
    html: <a href="https://www.google.com/{{value}}" target="_blank" style="color:blue; font-weight: bold; ">{{ rendered_value }}</a> ;;

  }


  measure: count_formatted {
    type: string
    sql:
        CASE WHEN ${count} > 900 THEN concat('$',${count})
        ELSE concat(round(${count}/100,2),'%') END
    ;;
  }

  dimension: state_pic {
    # School Logo retreived from S3
    label: "state pic"
    sql: ${state} ;;
    html:<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_{{ value }}.svg/250px-Flag_of_{{ value }}.svg.png" width="150px" height="100%" /> ;;
  }



  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
<<<<<<< HEAD
    drill_fields: [orders.id]
=======
>>>>>>> branch 'master' of git@github.com:philip-martinelli/ecommerce.git
    order_by_field: city_sort
    #map_layer_name: state_layer
  }
<<<<<<< HEAD
=======
dimension: city_sort {
    type: string
    hidden: yes
    sql:
    case when
            ${city} = "San Jose" then "a"
            when ${city} = "Los Angeles" then "c"
            when ${city} = "Atlanta" then "b"
>>>>>>> branch 'master' of git@github.com:philip-martinelli/ecommerce.git

<<<<<<< HEAD
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
=======
            end
    ;;

    }

  dimension: city_name {
    type: string
    sql: ${TABLE}.city ;;
    #map_layer_name: state_layer
    html: <a href="https://www.google.com/{{value}}" target="_blank" style="color:blue; font-weight: bold; ">{{ rendered_value }}</a> ;;
>>>>>>> branch 'master' of git@github.com:philip-martinelli/ecommerce.git
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
    label: "Event "
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      month_num,
      month_name
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
    html:
    {% if value == 'm' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'f' %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;

  }

  dimension: is_female {
    type: yesno
    sql: ${gender} = "f" ;;
    html:
    {% if value == true %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ value }}</p>
    {% elsif value == false %}
    <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ value }}</p>
    {% endif %}
    ;;

  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;

  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    suggestions: ["California","New York"]
    # hidden: no
    # order_by_field: state_order
    }

  dimension: state_order {
    type: number
    sql: CASE WHEN ${state} = "California" then 3
        WHEN ${state} = "New York" then 1
        when ${state} = "Alabama" then 2
        end;;
  }

  parameter: limit_param {
    type: unquoted
  }

  dimension: in_state_set {
    type: yesno
    sql:
       ${state} IN (
                SELECT state from ${TABLE} order by state limit {% parameter limit_param %}
              )
    ;;
  }

  dimension: has_order {
    type: yesno
    sql:
        EXISTS(
                SELECT orders.id from orders as o WHERE users.id = o.user_id
              )
    ;;
  }

  dimension: has_order_in_past_30_days {
    type: yesno
    sql:
  EXISTS(
          select
              o.user_id
            from orders as o
            WHERE users.id = o.user_id
            AND
            (((o.created_at ) >= ((CONVERT_TZ(DATE_ADD(DATE(CONVERT_TZ(orders.created_at,'America/Chicago','America/Juneau')),INTERVAL -29 day),'America/Juneau','America/Chicago')))
            AND (o.created_at) < ((CONVERT_TZ(DATE_ADD(DATE_ADD(DATE(CONVERT_TZ(orders.created_at,'America/Chicago','America/Juneau')),INTERVAL -30 day),INTERVAL 30 day),'America/Juneau','America/Chicago')))))
          )
    ;;
  }

  dimension: case_dim {
    case: {
      when: {
        sql:  1=2 ;;
        label: "Male and Female"
      }
      when: {
        sql: ${gender}="m" ;;
        label: "Male"
      }
      when: {
        sql: ${gender} = "f" ;;
        label: "Female"
      }
    }
  }

  dimension: zip {
    type: number
    sql: ${TABLE}.zip ;;
    map_layer_name: zip_layer
  }

  measure: count_regular {
    type: count
    drill_fields: [basic*]
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

  measure: percent_of_t {
    type: percent_of_total
    sql: ${count} ;;
    drill_fields: [users.city,percent_of_t]
  }

  measure: all_users {
    drill_fields: [last_name]
    type: number
    description: "test description"
    sql: ${count_users_with_orders} + ${count_users_without_orders} ;;
    link: {
      label: "pivot test-explore"
      url: "https://self-signed.looker.com:9999/explore/ecommerce/users?fields=users.state,users.count_users_with_orders&f[users.gender]={{ users.gender._filterable_value}}"
    }
  }

  measure: count {
    type: count

  }
  measure: yesno_count {
    type: yesno
    sql: ${count} > 0 ;;
  }

  measure: filered_measure_count {
    type: average
    sql: ${id} ;;
    # filters: {
    #   field: yesno_count
    #   value: "yes"
    # }
  }
  measure: meas_ref_dim {
    type: number
    sql: (${filered_measure_count}/${id}) ;;
  }

#   dimension: yesno_ref_measure {
#     type: yesno
#     sql: ${count} > 1 ;;
#   }
measure: sum {
  type: sum
  sql: ${id} ;;
}

parameter: measure_toggle {
  type: unquoted
  suggestions: ["count","sum"]
}

measure: dynamic_measure {
  label: "{% parameter measure_toggle %}"
type: number
sql:
    CASE WHEN '{% parameter measure_toggle %}' = 'count' THEN ${count}
          WHEN '{% parameter measure_toggle %}' = 'sum' THEN ${sum}
          END
;;
}



set: basic {
  fields: [id,age,state]
}
set: advanced {
  fields: [city,created_date,count_regular]
}



}
