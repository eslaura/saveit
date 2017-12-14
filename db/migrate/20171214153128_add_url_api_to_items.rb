class AddUrlApiToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :url_api, :string
  end
end
