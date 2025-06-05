# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 25 # number of records per page
  config.window = 1           # number of pages adjacent to the current one
  config.outer_window = 0     # we don't want to show more pages besides the beginning and end
  config.left = 1             # always show the first page
  config.right = 1            # always show the last page
  # config.max_per_page = nil
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = nil
  # config.params_on_first_page = false
end
