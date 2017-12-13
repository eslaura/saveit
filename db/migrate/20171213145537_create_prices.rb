class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.integer :price
      t.string :currency
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
