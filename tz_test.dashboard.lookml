- dashboard: tz_test
  title: Tz Test
  layout: tile
  tile_size: 100

  filters:

  elements:
    - name: UTC
      model: ecom
      explore: orders
      type: table
      fields:
      - orders.created_date
      fill_fields:
      - orders.created_date
      sorts:
      - orders.created_date desc
      limit: 500
      query_timezone: UTC
      row: 0
      col: 8
      width: 8
      height: 6
    - title: chicago
      name: chicago
      model: ecom
      explore: orders
      type: table
      fields:
      - orders.created_time
      sorts:
      - orders.created_time desc
      limit: 500
      query_timezone: America/Chicago
      row: 0
      col: 16
      width: 8
      height: 6
