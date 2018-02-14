view: new_users_pdt {
  derived_table: {
    sql:  Select
          state,city
          FROM users
          where state in ('California','New York','Washington')
          and city in ('Yonkers','San jose')
    ;;
  }

  dimension: state  {}
  dimension: city {}
   }
