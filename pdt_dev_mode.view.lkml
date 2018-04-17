view: pdt_dev_mode {
  derived_table: {
    sql: select *  from users limit 1 ;;
  persist_for: "24 hours"
  }

  dimension: id {
    type: number
  }

  dimension: state {
    type: string
  }

  }
