class AddOldPriceAndNewPriceToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :old_price, :integer
    add_column :notifications, :new_price, :integer
  end
end
