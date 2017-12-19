class ChangeOldAndNewPriceToPriceCentsForNotifications < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :old_price, :old_price_cents
    rename_column :notifications, :new_price, :new_price_cents
  end
end
