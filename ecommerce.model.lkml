connection: "thelook"

# include all the views
include: "*.view"
# include: "order_items.view"
# include: "orders.view"
# include: "products.view"
# include: "users.view"
# include: "events.view"
# include: "inventory_items.view"
# include: "schema_migrations.view"
# include: "orders_extended.view"
# include: "user_data.view"
# include: "users_pdt.view"
# include: "users_nn.view"
# include: "max_date_dt.view"




# include all the dashboards
include: "*.dashboard"

explore: users_test_pdt_with {}

explore: events {
  join: users {
   # type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  always_filter: {
    filters: {
      field: users.state
      value: "_California"
    }
  }
  #sql_always_where: ${users.state} <> 'California'  ;;
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: orders {
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
explore: users {
  view_name: users
  from: users
# fields: [users.basic*]
  join: orders {
    sql_on: ${users.id}=${orders.user_id} ;;
    relationship: one_to_many
    type: left_outer
  }
}

explore: users_extended {
  extends: [users]
#   fields: [users.basic*,users.advanced*]
  join: orders_extended {
    type: inner
    relationship: one_to_many
    sql_on: ${orders_extended.id} = ${orders.id};;
  }
}


explore: users_pdt {}

explore: users_nn {}




explore: orders {
#   from: orders
  join: order_items {
    relationship: one_to_many
    sql_on: ${orders.id} = ${order_items.order_id} ;;
  }
}

explore: orders_with_users {
  label: "test"
  view_name: users # declares users as base view
  extends: [orders] # extends order into users, but the from: users overwrites the
  # from: orders parameter, therefore making users the base view.
  join: orders { # since users has been declared as the base view, we need to join in orders to make
    # the join with order_items work
    sql_on: ${orders.user_id}= ${users.id} ;;
    relationship: one_to_many
    type: left_outer
  }
}
