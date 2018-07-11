connection: "thelook"

# include all the views
#include: "*.view"
include: "order_items.view"
include: "orders.view"
include: "products.view"
include: "users.view"
include: "events.view"
include: "inventory_items.view"
include: "schema_migrations.view"
include: "orders_extended.view"
include: "user_data.view"
include: "users_pdt.view"
include: "users_nn.view"
include: "orders_two.view"
include: "max_date_dt.view"
include: "users_facts.view"
include: "users_new.view"
include: "new_users_pdt.view"
include: "user_Cross.view"

include: "note_test.dashboard"
##
########
##

# include all the dashboards
include: "*.dashboard"

# explore: events {
#   join: users {
#    # type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

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
      value: "California"
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

explore: products {
  sql_always_where: ${category} = 'Active' ;;
  join: inventory_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${inventory_items.product_id}=${products.id} ;;
  }
}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
explore: users {
  sql_always_where: ${state} is not NULL ;;
  view_name: users
  from: users
# fields: [users.basic*]
  join: orders {
    sql_on: ${users.id}=${orders.user_id} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: user_cross {
type: cross
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


explore: users_pdt_scratch_schem_test {}

explore: users_nn {}




explore: orders {
  sql_always_where: {% condition order_items.returned_date  %} ${orders.created_date} {% endcondition %};;
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

explore: orders_test {
  from: orders
  join: users_new {
    fields: [users_new.city,users_new.zip,users_new.country]
    relationship: one_to_many
    sql: ${users_new.id} = ${orders_test.user_id} ;;
  }
  join: users_new_b {
    from: users_new
    fields: [users_new_b.city,users_new_b.zip,users_new_b.country]
    relationship: one_to_many
    sql: ${users_new_b.id} = ${orders_test.user_id} ;;
  }
#   sql_always_where:(CASE WHEN {% parameter users_new.state_list %} = "California" THEN ${state} = "California"
#                 WHEN {% parameter users_new.state_list %} = "Oregon" THEN ${state} = "Oregon"
#                 ELSE ${state} != "California" AND ${state} != "Oregon" END) = TRUE  ;;
}
explore: new_users_pdt {}
explore: users_new {
  fields: [users_new.id,users_new.orders_field]
  join: orders {
    fields: [orders.id,orders.user_id]
    sql_on: ${orders.user_id} = ${users_new.id} ;;
  }
}
include: "extend_test.view"
explore:extend_test_extend  {}
include: "sql_runner_query.view"
explore: sql_runner_query {}
