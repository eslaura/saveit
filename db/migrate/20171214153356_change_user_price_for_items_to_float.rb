class ChangeUserPriceForItemsToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :user_price, :float
  end
end
