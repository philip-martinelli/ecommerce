include: "test.base.lkml"
view: users_ndt {
 derived_table: {
   explore_source: users {
     column: user_id {field: users.id}
     column: order_id  {field: orders.id }
    column: created_date {field: users.created_date }
    derived_column: first_order_date {
      sql:(select min(sub.created_at) from orders as sub where sub.user_id = asdc57c29276f.user_id)  ;;
    }
   }
 }

dimension: user_id {}
dimension: created_date {
  type: date
}
  dimension: first_order_date {
    type: date
  }



}
