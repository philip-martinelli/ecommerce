view: random_pdt {
  derived_table: {
    sql:
      SELECT
        "123" as field
        UNION ALL
      SELECT
        "abc" as field
        UNION ALL
      SELECT
        "456" as field
        UNION ALL
      SELECT
        "def" as field
    ;;
  }

  dimension: field {}




  }
