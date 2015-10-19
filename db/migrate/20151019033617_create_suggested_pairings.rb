class CreateSuggestedPairings < ActiveRecord::Migration
  def change
    create_table :suggested_pairings do |t|
      t.string :musician
      t.string :author
      t.string :news_source
      t.string :persisted_dictionary

      t.timestamps null: false
    end
  end
end
