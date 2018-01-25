view: products {
  #sql_table_name: {% parameter schema_test %}.products ;;

  parameter: schema_test {
    type: number

  }

  parameter: parameter_test {
    type: number

  }

  filter: filter_test {
    type: number
    #default_value: "one"
  }

  measure: count_test {
    type: count
    html:
        {% assign fil = _filters['products.filter_test'] | times: 1 %}
        {% if fil > value %}
        <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% elsif fil <= value  %}
        <p style="color: black; background-color: pink; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% else %}
        <p style  "color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
        {% endif %}
    ;;

    # html:
    # {% if _filters['products.schema_test'] == "test" %}
    # <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    # {% else %}
    # <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    # {% endif %}
    # ;;

    # html: {% if value > {{ daily_bucketed_totals.abg_high_total_hits_excluding_quotelist_high_threshold._filterable_value }}
    # <p style="color: #585858; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    # {% elsif value <= {{ daily_bucketed_totals.abg_high_total_hits_excluding_quotelist_high_threshold._filterable_value }} and value >= {{ daily_bucketed_totals.abg_high_total_hits_excluding_quotelist_medium_threshold._filterable_value }}
    #   <p style="color:#585858; background-color: #F7D358; font-size:100%; text-align:center">{{ rendered_value }}</p>
    #   {% else %}
    #   <p style="color:#585858; background-color: #F78181; font-size:100%; text-align:center">{{ rendered_value }}</p>
    #   {% endif %}
    #   ;;
  }

  dimension: test  {
    type: string
    sql: "{% parameter schema_test %}" ;;
  }

  dimension: test_two  {
    type: string
    sql: " " ;;
    html:
        {% if _filters['products.schema_test']  %}
    _filters['products.schema_test'];;
  }


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    html: <a href={{products.drill_link._value}}>{{ value }}</a> ;;

  }

  measure: item_count {
    type: count_distinct
    sql: ${item_name} ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  # html:
  #   {% if value == 'Accessories' %}
  #   <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
  #   {% elsif value == 'Jeans' %}
  #   <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
  #   {% else %}
  #   <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
  #   {% endif %}
  #   ;;
  }

  dimension: drill_link {
    type: string
    sql:
    {% if products.department._is_filtered %}
    "https://self-signed.looker.com:9999/explore/ecommerce/products?fields=products.brand&f[products.department]=&limit=500&vis=%7B%7D&filter_config=%7B%22products.department%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%7D%5D%7D&origin=share-expanded"
    {% else %}
    "https://self-signed.looker.com:9999/explore/ecommerce/products?qid=aIjL6GqOWU2YDDi0AmkZ3u&toggle=fil"
    {% endif %}
    ;;
  }


  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: foo {
    type: sum
    sql:  ${TABLE}.foo ;;
  }

  measure: count {
    type: count
    html:
    {% if value > 1000 %}
    <a href="{{ link }}" style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ value }}</a>

    {% elsif value > 500 %}
        <a href="{{ link }}" style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ value }}</a>
    {% else %}
        <a href="{{ link }}" style="color: black; background-color: orange; font-size:100%; text-align:center">{{ value }}</a>
    {% endif %}
    ;;
    drill_fields: [id, item_name, inventory_items.count]
  }
}
