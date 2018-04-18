class CreateIndexAlphabets < ActiveRecord::Migration
  def change
    create_table :index_alphabets do |t|
      t.string :title
      t.references :state, index: true, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
