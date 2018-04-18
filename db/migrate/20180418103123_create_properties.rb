class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :id_from_rightmove, unique: true
      t.references :index_alphabet, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.string :property_link
      t.string :image_url
      t.string :price
      t.string :description
      t.string :address
      t.string :street
      t.string :property_for
      t.string :city_or_town
      t.date :linked_on

      t.timestamps null: false
    end
  end
end
