view: sql_runner_query {
  derived_table: {
    sql: select "joe" as account,1 as order_num,TIMESTAMP('2018-01-01') as order_dt
      UNION ALL
      select "joe",2,TIMESTAMP('2018-02-01')
      UNION ALL
      select "joe",3,TIMESTAMP('2018-03-01')
      UNION ALL
      select "joe",4,TIMESTAMP('2018-04-01')

      UNION ALL
      select "jane",1,TIMESTAMP('2018-02-01')
      UNION ALL
      select "jane",2,TIMESTAMP('2018-03-01')
      UNION ALL
      select "jane",3,TIMESTAMP('2018-04-01')
      UNION ALL
      select "jane",4,TIMESTAMP('2018-10-01')
       ;;
  }

  measure: count {
    type: count
  }

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: order_num {
    type: string
    sql: ${TABLE}.order_num ;;
  }

  dimension_group: order_dt {
    type: time
    timeframes: [date,month]
    sql: ${TABLE}.order_dt ;;
  }

  dimension: two {
    type: date_time
    sql: (select sub.order_dt from
      (select "joe" as account,1 as order_num,TIMESTAMP('2018-01-01') as order_dt
      UNION ALL
      select "joe",2,TIMESTAMP('2018-02-01')
      UNION ALL
      select "joe",3,TIMESTAMP('2018-03-01')
      UNION ALL
      select "joe",4,TIMESTAMP('2018-04-01')

      UNION ALL
      select "jane",1,TIMESTAMP('2018-02-01')
      UNION ALL
      select "jane",2,TIMESTAMP('2018-03-01')
      UNION ALL
      select "jane",3,TIMESTAMP('2018-04-01')
      UNION ALL
      select "jane",4,TIMESTAMP('2018-10-01')) as sub where sql_runner_query.account = sub.account and sub.order_num = 2) ;;
  }

  dimension: four {
    type: date_time
    sql: (select sub.order_dt from
      (select "joe" as account,1 as order_num,TIMESTAMP('2018-01-01') as order_dt
      UNION ALL
      select "joe",2,TIMESTAMP('2018-02-01')
      UNION ALL
      select "joe",3,TIMESTAMP('2018-03-01')
      UNION ALL
      select "joe",4,TIMESTAMP('2018-04-01')

      UNION ALL
      select "jane",1,TIMESTAMP('2018-02-01')
      UNION ALL
      select "jane",2,TIMESTAMP('2018-03-01')
      UNION ALL
      select "jane",3,TIMESTAMP('2018-04-01')
      UNION ALL
      select "jane",4,TIMESTAMP('2018-10-01')) as sub where sql_runner_query.account = sub.account and sub.order_num = 4) ;;
  }

dimension: timediff_2_and_4 {
type: number
hidden: yes
sql:
timestampdiff(hour,
      (select sub.order_dt from
      (select "joe" as account,1 as order_num,TIMESTAMP('2018-01-01') as order_dt
      UNION ALL
      select "joe",2,TIMESTAMP('2018-02-01')
      UNION ALL
      select "joe",3,TIMESTAMP('2018-03-01')
      UNION ALL
      select "joe",4,TIMESTAMP('2018-04-01')

      UNION ALL
      select "jane",1,TIMESTAMP('2018-02-01')
      UNION ALL
      select "jane",2,TIMESTAMP('2018-03-01')
      UNION ALL
      select "jane",3,TIMESTAMP('2018-04-01')
      UNION ALL
      select "jane",4,TIMESTAMP('2018-10-01')) as sub where sql_runner_query.account = sub.account and sub.order_num = 2),
      (select sub.order_dt from
      (select "joe" as account,1 as order_num,TIMESTAMP('2018-01-01') as order_dt
      UNION ALL
      select "joe",2,TIMESTAMP('2018-02-01')
      UNION ALL
      select "joe",3,TIMESTAMP('2018-03-01')
      UNION ALL
      select "joe",4,TIMESTAMP('2018-04-01')

      UNION ALL
      select "jane",1,TIMESTAMP('2018-02-01')
      UNION ALL
      select "jane",2,TIMESTAMP('2018-03-01')
      UNION ALL
      select "jane",3,TIMESTAMP('2018-04-01')
      UNION ALL
      select "jane",4,TIMESTAMP('2018-10-01')) as sub where sql_runner_query.account = sub.account and sub.order_num = 4));;
}

dimension: timediff {
  type: number
  sql: case when ${order_num} = 4 then ${timediff_2_and_4} end ;;
}
measure: av {
  type: average
  sql: ${timediff} ;;

}

}
