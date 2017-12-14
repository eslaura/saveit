class ChangePriceForPriceToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :prices, :price, :float
  end
end
