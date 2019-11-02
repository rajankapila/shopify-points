class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.references :shop, index: true, foreign_key: true
      t.string :customer_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :points, :default => 0

      t.timestamps
    end
  end
end
