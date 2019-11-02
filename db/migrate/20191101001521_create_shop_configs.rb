class CreateShopConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_configs do |t|
      t.references :shop, index: true, foreign_key: true
      t.integer :points_per_dollar, :default => 0
      t.timestamps
    end
  end
end
