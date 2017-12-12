class AddSrcToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :src, :string
  end
end
