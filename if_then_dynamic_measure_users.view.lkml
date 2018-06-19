view: if_then_dynamic_measure_users {
derived_table: {
  sql:

  SELECT
  *
  from users
  WHERE
  {% if if_then_dynamic_measure_users.CA_filter._is_filtered %}
  state = 'California'
  {% elsif if_then_dynamic_measure_users.NY_filter._is_filtered %}
  state = 'New York'
  {% elsif if_then_dynamic_measure_users.OR_filter._is_filtered %}
  state = 'Oregon'
  {% else %}
  1=1
  {% endif %}
  ;;
}
parameter: CA_filter {
  view_label: "Filter Options"
  label: "Filter CA"
  type: string
  default_value: "California"
}
  parameter: NY_filter {
    view_label: "Filter Options"
    label: "Filter NY"
    type: string
    default_value: "New York"
  }
  parameter: OR_filter {
    view_label: "Filter Options"
    label: "Filter OR"
    type: string
    default_value: "Oregon"
  }
dimension: state {}


 }
