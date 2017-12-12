class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.references :registration, foreign_key: true

      t.timestamps
    end
  end
end
