connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: users {
  from: users
  view_name: users
  join: orders {
    relationship: one_to_many
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
}

explore: order_items {
  from: order_items
  view_name: order_items
  join: inventory_items {
    relationship: many_to_one
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  }
  join: products {
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id};;
  }
}

explore: master_explore {
  extends: [users,order_items]
  join: orders {
    relationship: one_to_many
    sql_on: ${order_items.order_id} = ${orders.id}   ;;
  }
  join: users {
    relationship: one_to_many
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
}
