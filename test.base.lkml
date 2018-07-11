include: "users.view"
include: "orders.view"
include: "order_items.view"


explore: users_base {
  from: users
  view_name: users
}

explore: users {
  join: orders {
    sql_on: ${users.id}=${orders.user_id} ;;
  }
  join: order_items {
    sql_on: ${order_items.order_id} = ${orders.id} ;;
  }
}
