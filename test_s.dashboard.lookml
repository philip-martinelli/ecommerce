- dashboard: test_s'
  title: Test S's test
  layout: tile
  tile_size: 100

  filters:

  elements:
    - name: add_a_unique_name_1510013235
      title: Untitled Visualization
      model: ecommerce
      explore: users
      type: table
      fields: [users.created_month, users.gender, users.all_users]
      pivots: [users.gender]
      fill_fields: [users.created_month]
      sorts: [users.created_month desc, users.gender]
      limit: 500
      conditional_formatting_ignored_fields: []
