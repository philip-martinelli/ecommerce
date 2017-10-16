include: "orders.view"
view: orders_extended {
extends: [orders]
dimension: id_extended {
  type: number
  sql: ${TABLE}.id + 1 ;;
}
}
