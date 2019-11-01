class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  has_one :shop_config
  has_many :customer

  def api_version
    ShopifyApp.configuration.api_version
  end
end
