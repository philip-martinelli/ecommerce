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


# explore: orders {
#   from: orders
#   join: max_date_dt {
#     type: cross
#   }
# }


explore: orders {
  always_filter: {
    filters: {
      field: created_date
      value: "before yesterday"
    }
#     filters: {
#       field: created_month
#       value: "after 7 days ago"
#     }
  }
  sql_always_where: orders.created_at  >= (DATE_ADD(CURDATE(),INTERVAL -7 day)) ;;
  from: orders
  join: order_items {
    relationship: one_to_many
    sql_on: ${orders.id} = ${order_items.order_id} ;;
  }
}



explore: orders_with_users {
  from: users # declares users as base view
  extends: [orders] # extends order into users, but the from: users overwrites the
                    # from: orders parameter, therefore making users the base view.
  join: orders { # since users has been declared as the base view, we need to join in orders to make
                # the join with order_items work
    sql_on: ${orders.user_id}= ${orders_with_users.id} ;;
    relationship: one_to_many
    type: left_outer
  }
}

explore: users {
  # sql_always_where:{% if users.last_name._in_query %}
  #                   ${id} = (SELECT id from users WHERE {% parameter name_filter %}
  #                 {% else %}
  #                 1=1
  #                 {% endif %};;
}
