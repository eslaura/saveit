class AddNewNotificationToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :new_notification, :boolean, :default => true
  end
end
