class AddNotificationToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :notification, :boolean
  end
end
