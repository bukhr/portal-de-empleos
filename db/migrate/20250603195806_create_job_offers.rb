class CreateJobOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :job_offers do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :name
      t.string :public_name
      t.string :description
      t.string :requirements
      t.string :job_area
      t.string :job_type
      t.string :job_schedule
      t.integer :vacancies_count
      t.boolean :show_location
      t.string :location
      t.boolean :show_published_at
      t.date :published_at
      t.boolean :show_salary_range
      t.integer :min_salary
      t.integer :max_salary
      t.boolean :use_fantasy_name
      t.boolean :visible
      t.timestamps
    end
  end
end
