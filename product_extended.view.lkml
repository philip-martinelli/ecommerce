include: "products.view.lkml"

view: product_extended {
  extends: [products]

  dimension: foo {
    type: number
    sql: ${TABLE}.foo ;;
  }

  }
