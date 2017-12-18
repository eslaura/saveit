class ChangePriceForItemsToInteger < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :user_price, :user_price_cents
    change_column :items, :user_price_cents, :integer
    rename_column :items, :price, :price_cents
    change_column :items, :price_cents, :integer
  end
end
