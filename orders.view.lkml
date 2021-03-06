view: orders {
sql_table_name: demo_db.orders ;;

  parameter: test {
    type: unquoted
  }

  measure: sum_test {
    type: sum
    sql: ${id}/{% parameter test %} ;;
  }

  filter: status_filter_test{
    type: string
    sql: ${status} = "complete" ;;
  }

dimension: filter_option {

  type: string
  sql: "one" ;;
  html:
          {% assign vartwo= "This filter is used to filter all dates for the past " %}
          {% assign var=  _filters['orders.created_date'] %}
          {{ vartwo | append: var}}
  ;;
}

  measure: date_min {
    type: date
    sql: min(${TABLE}.created_at) ;;
  }

  dimension: yesno_min_date {
    type: yesno
    sql: ${created_date} = (SELECT MIN(o.created_at) FROM orders o where o.user_id  = orders.user_id ) ;;
  }

  dimension: id {
    label: "Group Label"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  dimension: latest_id {
    type: number
    sql:
        (SELECT
          o.id
        FROM orders o
          WHERE o.user_id = orders.user_id
              AND o.created_at = (SELECT max(oo.created_at) FROM orders oo WHERE oo.user_id = orders.user_id))
    ;;
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
      year,
      day_of_month,
      day_of_week,
      week_of_year
    ]
    convert_tz: no
    sql: ${TABLE}.created_at ;;
  }

  dimension: case_year {
    case: {
      when: {
        label: "2017"
        sql: ${created_year} = 2017 OR (${created_year} = 2016 AND ${created_week_of_year} < 52 ;;

        #  when (curdate()) - 12) < 1  then   (case when year(curdate) = created year then created  year else year(dateadd(created_date -1 year))

        #when week of year of now minus period < 1, attribute lagging weeks from past year to current year
        # when week of year of minus minus period >= 1, all gucci fam
      }
      when: {
        label: "2018"
        sql: ${created_year} = 2018  ;;
      }
    }
  }

  dimension: year_test {
    type: string
    sql: CASE when (weekofyear(curdate()) - 12) < 1  then   (case when ${created_week_of_year} <= 53 and ${created_week_of_year} >  then year(date_add(${TABLE}.created_at, interval 1 year)) else ${created_year} end)
          else ${created_year} end
 ;;
  }

  dimension: created_last_day_of_week {
    type: date
    sql: DATE_ADD(${created_week}, INTERVAL 7 DAY);;
  }

  dimension: week_day {
    type: date_day_of_week
    sql: ${created_day_of_week} ;;
    html:
    {% if value == 'Saturday' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'Sunday' %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color:orange">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }


  dimension: created_d {
    type: string
    sql: CAST(${TABLE}.created_at AS CHAR) ;;
  }

  dimension_group: test_created_d {
    type: time
    timeframes: [date,year,month]
    datatype: date
    sql: ${created_d} ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: status {
    label: "STATUS"
    type: string
    sql: UPPER(${TABLE}.status) ;;
  }
  measure: status_agg {
    type: count
    filters: {
      field: status
      value: "complete"
    }
  }

  dimension: status_two {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    label: "userszzzz_id"
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [users.state]
#     link: {
#       label: "test"
#       url: "/explore/ecommerce/users?fields=users.state,users.count,&f[users.created_date]={{ _filters['orders.created_date'] | url_encode }}"
#       }
  }

  measure: count_test {
    type: count
   # sql: ${id} ;;
    filters: {
      field: created_date
      value: "1 month ago"
    }
  }

  filter: last_one_day_filter {
    type: date_time
  }

  dimension: last_one_day {
    type: yesno
    sql: {% condition last_one_day_filter %} ${created_raw} {% endcondition %} ;;
  }

  measure: count_last_three_months {
    type: count
    filters: {
      field: status
      value: "complete"
}
    filters: {
      field: created_date
      value: "3 months ago"
    }
    filters: {
      field: user_id
      value: "100"
    }
  }


  dimension: yesnotest{
    type: yesno
    sql: {% condition userid_plus_one %} user_id + 1 {% endcondition %};;
  }

  filter: userid_plus_one {
    type: number
  }


  dimension: school_logo {
    # School Logo retreived from S3
    label: "School Logo"
    sql: ${pic} ;;
    html:<img src="https://image.freepik.com/free-icon/png-file-format-symbol_318-45313.jpg" width="150px" height="100%" /> ;;
  }

  dimension: pic {
    sql: ('https://image.freepik.com/free-icon/png-file-format-symbol_318-45313.jpg') ;;
  }

  dimension: pic_image {
    sql: ${pic};;
    html: <img src="{{ value }}" width="100" height="100"/> ;;
  }

#   dimension: in_last_12_month {
#     type: yesno
#     sql:  ${created_date} >= DATE_ADD(date_format(${max_date_dt.max_date_raw},'%Y-%m-01'), INTERVAL -12 MONTH)
#     ;;
#   }

  dimension: month_part {
    type: number
    sql: SELECT
date(created_at)
,(WEEK(date(created_at)) - WEEK(str_to_date(concat(extract(year from date(created_at)),"-",extract(month from date(created_at)),"-","01"),"%Y-%m-%d")) + 1)
FROM users
group by 1,2
order by 1 desc
Limit 100 ;;
convert_tz: no
  }

  measure: list_type {
    type: list
    list_field: created_week
  }

  measure: count_format {
    type: count
    value_format: "0\s"
    html:
    {% if value < 120 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value >= 120 %}
    <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
    ;;
  }

}
