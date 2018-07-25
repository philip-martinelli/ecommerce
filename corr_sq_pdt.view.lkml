view: corr_sq_pdt {
derived_table: {
  sql:
  SELECT
date_format(date,'%Y-%m-01'),dist_orders
FROM (
SELECT date
     ,(SELECT count(DISTINCT id)
       FROM   orders
       WHERE  created_at BETWEEN DATE_ADD(date_format(g.date,'%Y-%m-01'), INTERVAL -2 MONTH) AND DATE_ADD(DATE_ADD(date_format(g.date,'%Y-%m-01'),INTERVAL 1 MONTH), INTERVAL -1 DAY)
      ) AS dist_orders
FROM  (
      select
      date from (
            select
              date_format(
              adddate('2016-1-1', @num:=@num+1),
              '%Y-%m-%d') date
              from
                  orders,
              (select @num:=-1) num
              limit
                  366
          ) as dt
          where year(date) in (2016)
      ) g
)s
GROUP BY 1,2;;
}

}
