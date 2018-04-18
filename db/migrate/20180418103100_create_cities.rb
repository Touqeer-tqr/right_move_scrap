class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.references :index_alphabet, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
