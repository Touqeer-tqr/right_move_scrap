class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :id_from_rightmove, unique: true
      t.references :index_alphabet, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.string :image_url
      t.string :property_for
      t.string :property_link
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :postal_code
      t.string :road
      t.string :city_name
      t.string :country
      t.string :state_name
      t.string :listed_on
      t.string :asking_price
      t.string :description
      t.string :beds
      t.string :last_sold_price
      t.string :last_sold_date

      t.timestamps null: false
    end
  end
end
