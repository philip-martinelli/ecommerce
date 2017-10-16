connection: "thelook"

# include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
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

# Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} and ${users.state} = "{{ _user_attributes['state'] }}"    ;;
#     fields: []
#   }
}


explore: orders {
  always_filter: {
    filters: {
      field: status_two
      value: "{{ _filters['orders.check_one'] }}"
    }
}
}

  explore: orders_two {
    join: order_items {
      relationship: one_to_many
     # type: left_outer
      sql_on: ${orders_two.id} = ${order_items.order_id}
      --AND {% condition orders_two.created_date %} ${order_items.returned_date} {% endcondition %}
      ;;
    }





  }


  explore: users {
    access_filter: {
      user_attribute: state
      field: state
    }

    join: orders {
      relationship: one_to_many
      type: left_outer
      sql_on: ${users.id} = ${orders.user_id} ;;
    }
  }

  map_layer: zip_layer {
    property_key: "id"
    format: topojson
    file: "California.topo.json"
  }

  map_layer: state_layer {
    property_key: "NAME"
    file: "Cities2015.json"
  }

#explore: oi {}
