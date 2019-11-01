class ShopConfig < ApplicationRecord
  belongs_to :shop
  # validate value is number greater than 0 and less than or equal to 1000 to avoid issues
  validates :points_per_dollar, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
end
