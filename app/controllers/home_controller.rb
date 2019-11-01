# frozen_string_literal: true

class HomeController < AuthenticatedController
  before_action :set_shop

  def index
    # Get customers based on shop_id and paginate
    @customers = Customer.where(shop_id: @current_shop.id)
      .order(last_name: :desc).page(params[:page]).per(10)
  end

  # POST /update_points_per_dollar
  def update_points_per_dollar
    # Set new points_per_dollar value
    @current_shop.shop_config.points_per_dollar = params["points_per_dollar"]

    # Save new shop config
    if @current_shop.shop_config.save
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  # Load current Shop
  def set_shop
    # Load the current Shopify Shop from the admin
    shopify_shop = ShopifyAPI::Shop.current
    @current_shop = Shop.find_by(shopify_domain: shopify_shop.domain)

    # Create a shop_config if it doesn't exist (tried in shop model with
    # after_create action but didn't work)
    if @current_shop && @current_shop.shop_config.nil?
      @current_shop.shop_config = ShopConfig.new
      @current_shop.save
    end
  end
end
