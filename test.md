# Liquid, what is it good for?

Put your documentation here! Your text is rendered with [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown).

Click the "Edit Source" button above to make changes.



# 1: nifty front-end formatting

- #### conditional formatting fields based on their values ####

```
dimension: status {
  sql: ${TABLE}.status ;;
  html:
    {% if value == 'Paid' %}
      <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'Shipped' %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
;;
}
```
![img](https://discourse.looker.com/uploads/default/214/d8a56dfe54fb2326.png)

- #### dynamic linking ####

```
dimension: name {
  link: {
    label: "Business Pulse By State Dashboard"
    url: "https://learn.looker.com/dashboards/694?State={{ _filters['users.state'] | url_encode }}"
  }
}
```
- ####  masking a field ####

```
dimension: ssn {
    type: string
    sql:
      CASE WHEN '{{ _user_attributes["can_see_ssn"] }}' = 'y'
        THEN ${TABLE}.ssn
      ELSE
        MD5(${TABLE}.ssn || ${TABLE}.salt)
      END ;;
    #Note: || is string concatenation. Update as necessary for your SQL dialect.
    # We are illustrating a salted hash to mask sensitive data, but you should
    # consult with your information security team to evaluate the acceptability of this approach.
    html:
       {% if _user_attributes["can_see_ssn"]  == 'y' %}
         {{ value }}
       {% else %}
         [Masked]
       {% endif %}
       ;;
 }
```

# 2: dynamic sql adjustment

 - #### changing join conditions

```
 explore: dates {
  join: dynamic_order_counts {
    sql_on:
      ${dynamic_order_counts.period} =
      {% if dates.reporting_date._in_query %}
        ${dates.date_string}
      {% elsif dates.reporting_week._in_query %}
        ${dates.week_string}
      {% else %}
        ${dates.month_string}
      {% endif %} ;;
  }
}

```

- #### dynamic fields

```
parameter: measure_type {
suggestions: ["sum","average","count","min","max"]
 }

parameter: dimension_to_aggregate {
type: unquoted
allowed_value: {
  label: "Total Sale Price"
  value: "sale_price"
}
allowed_value: {
  label: "Total Gross Margin"
  value: "gross_margin"
}

}

measure: dynamic_agg {
type: number
label_from_parameter: dimension_to_aggregate
sql: case when  {% condition measure_type %} 'sum' {% endcondition %}  then sum( ${TABLE}.{% parameter dimension_to_aggregate %})
    when {% condition measure_type %} 'average' {% endcondition %}  then avg( ${TABLE}.{% parameter dimension_to_aggregate %})
    when {% condition measure_type %} 'count' {% endcondition %}  then count( ${TABLE}.{% parameter dimension_to_aggregate %})
    when {% condition measure_type %} 'min' {% endcondition %}  then min( ${TABLE}.{% parameter dimension_to_aggregate %})
    when {% condition measure_type %} 'max' {% endcondition %}  then max( ${TABLE}.{% parameter dimension_to_aggregate %})
    else null end;;
}
```

```
dimension: date {
     label_from_parameter: date_granularity
     sql:
       CASE
         WHEN {% parameter date_granularity %} = 'Day' THEN
           ${created_date}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Month' THEN
           ${created_month}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Quarter' THEN
           ${created_quarter}::VARCHAR
         WHEN {% parameter date_granularity %} = 'Year' THEN
           ${created_year}::VARCHAR
         ELSE
           NULL
       END ;;
 }
```

- #### relation selection

```
view: t2 {
 sql_table_name:  {% parameter tablename %}

 parameter: tablename {
  type: unquoted
  allowed_value: {
    label: “UK”
    value: “00001.ga_sessions”
  }
  allowed_value: {
    label: “Germany”
        value: “00002.ga_sessions”
    }
 }
}
```
