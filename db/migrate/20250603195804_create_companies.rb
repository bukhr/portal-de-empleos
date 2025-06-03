class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :identifier_value
      t.integer :identifier_type
      t.string :name
      t.string :fantasy_name
      t.string :image_url
      t.string :background_color
      t.timestamps
    end
  end
end
