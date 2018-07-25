connection: "thelook"

#include: "*.view.lkml"         # include all views in this project
include: "users.view.lkml"
include: "orders.view.lkml"
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "test.base.lkml"
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

explore: users_extended {
  extends: [users_base]
}
