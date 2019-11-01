class OrdersPaidJob < ActiveJob::Base

  # Job to add points to user after order is paid
  def perform(shop_domain:, webhook:)
    # Load the shop
    shop = Shop.find_by!(shopify_domain: shop_domain)
    # Check to see if the points are great than zero
    if shop.shop_config.points_per_dollar > 0
      # Get the total dollars spent rounded down
      total_spent = webhook["total_price"].to_i

      # Extract the customer
      shopify_customer = webhook["customer"]

      # Find or create the customer
      @customer = Customer.where(customer_id: shopify_customer["id"])
        .first_or_create do |customer|
        customer.shop_id = shop.id
        customer.email = shopify_customer["email"]
        customer.first_name = shopify_customer["first_name"]
        customer.last_name = shopify_customer["last_name"]
      end

      # Calculate the points earned based on total spent including taxes and shipping because
      # I am a nice guy
      points_earned = shop.shop_config.points_per_dollar * total_spent
      @customer.points += points_earned
      @customer.save

      # Send email to customer indicating points earned using a deferred job
      UserMailer.points_email(@customer, points_earned, shop).deliver_later
    end
  end
end
