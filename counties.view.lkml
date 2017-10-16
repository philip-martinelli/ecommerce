view: counties {
  sql_table_name: geo.counties ;;

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension: fips_class {
    type: string
    sql: ${TABLE}.fips_class ;;
  }

  dimension: fips_county {
    type: string
    sql: ${TABLE}.fips_county ;;
  }

  dimension: fips_state {
    type: string
    sql: ${TABLE}.fips_state ;;
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  measure: count {
    type: count
    drill_fields: [county_name]
  }
}
