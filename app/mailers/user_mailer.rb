class UserMailer < ActionMailer::Base
  default from: "no-reply@shopify-points.herokuapp.com"

  # Send email indicating points earned
  def points_email(user, points, shop)
    @user = user
    @points = points
    @shop = shop
    mail(
      to: user.email,
      subject: "Hi, #{user.first_name}, you earned some points on #{@shop.shopify_domain}!"      
    )
  end
end
