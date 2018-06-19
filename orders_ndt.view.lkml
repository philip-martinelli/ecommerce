
#  include: "ecom.model"

  view: ndt_test {
    derived_table: {
      explore_source: orders {
        column: created_date {field: orders.created_date}
      }
    }
    dimension_group: created_date {
      type: time
      timeframes: [date,time]
      #datatype: date
    }






    }
