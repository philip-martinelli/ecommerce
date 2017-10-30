connection: "thelook"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# and define the joins that connect them together.

explore: order_items {
  join: orders {
    relationship: many_to_one
    sql_on: {% if orders.id._in_query and orders.created_date._in_query %}
 ${orders.id} = ${order_items.order_id} AND ${orders.created_raw} = ${order_items.returned_raw}
{% elsif orders.id._in_query %}
${orders.id} = ${order_items.order_id}
{% elsif orders.created_date._in_query %}
${orders.created_raw} = ${order_items.returned_raw}
{% endif %}
    ;;
  }
}
