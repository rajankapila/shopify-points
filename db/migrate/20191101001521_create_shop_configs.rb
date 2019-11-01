class CreateShopConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_configs do |t|
      t.integer :shop_id
      t.integer :points_per_dollar, :default => 0

      t.timestamps
    end
  end
end
