class AddReadToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :read, :boolean, :default => false
  end
end
