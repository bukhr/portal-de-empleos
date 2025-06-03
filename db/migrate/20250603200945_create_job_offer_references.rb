class CreateJobOfferReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :job_offer_references do |t|
      t.references :job_offer, null: false, foreign_key: true
      t.integer :source
      t.string :external_id
      t.string :external_url
      t.timestamps
    end
  end
end
