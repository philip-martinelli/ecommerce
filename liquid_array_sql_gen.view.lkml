view: liquid_array_sql_gen {
  derived_table: {
    sql:
        {% assign field_array_string = "" -%}
        {% if liquid_array_sql_gen.city._in_query -%}
        {% assign field_array_string = ",city" | append: field_array_string -%}
        {% endif -%}
        {% if liquid_array_sql_gen.state._in_query -%}
        {% assign field_array_string = ',state' | append: field_array_string -%}
        {% endif -%}
        {% assign field_array = field_array_string | split: ',' -%}
  select
      {% assign counter = 0 -%}
      {% assign counter_array_string = "" -%}
        {% for i in field_array  offset:1 -%}
          {% assign counter = counter | plus: 1 | downcase  -%}
          {% assign counter_array_string = counter_array_string | append: "," | append: counter -%}
        {% endfor -%}
      {% assign counter_array = counter_array_string | split: ',' -%}
        {% for number in counter_array -%}
        {% assign num = number | plus:0 -%}
          {% if num == 1 -%}
            {{ field_array[num] }}
          {% elsif num > 1 -%}
            {{ field_array[num] | prepend: "," }}
          {% endif -%}
        {% endfor -%}
    from users
    group by
        {% for number in counter_array -%}
              {% assign num = number | plus:0 -%}
                {% if num == 1 -%}
                  {{ field_array[num] }}
                {% elsif num > 1 -%}
                  {{ field_array[num] | prepend: "," }}
                {% endif -%}
              {% endfor -%}
          ;;
  }

  dimension: city {}
  dimension: state {}

  }
