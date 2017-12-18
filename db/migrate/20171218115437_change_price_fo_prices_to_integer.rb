class ChangePriceFoPricesToInteger < ActiveRecord::Migration[5.0]
  def change
    rename_column :prices, :price, :price_cents
    change_column :prices, :price_cents, :integer
  end
end
