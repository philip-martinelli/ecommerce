include: "extend_test.view"
view: extend_test_extend {
  extends: [extend_test_base]
}






view: extend_test_base {
  derived_table: {
    sql: select state from users where {% condition filter_f %} created_at {% endcondition %} ;;
  }

  filter: filter_f {
    type: date
  }

  dimension:  state {}
}
