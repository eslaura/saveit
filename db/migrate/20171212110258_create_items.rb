class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :color
      t.string :original_store
      t.integer :size
      t.integer :price
      t.references :user, foreign_key: true
      t.boolean :favorite
      t.integer :user_price

      t.timestamps
    end
  end
end
