view: param_dt_ex {
derived_table: {
  sql:
      SELECT * FROM
     -- {{ _user_attributes['number_test'] }}
      {% parameter table_param %}
  ;;
}

parameter: table_param {
  type: unquoted
  allowed_value: {
    label: "users"
    value: "users"
  }
  allowed_value: {
    label: "orders"
    value: "orders"
  }
}

dimension: id {
  type: number
}

}
