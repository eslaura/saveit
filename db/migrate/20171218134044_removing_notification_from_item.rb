class RemovingNotificationFromItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :notification
  end
end
