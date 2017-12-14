class ChangeColumnForItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :price, :float
  end
end
