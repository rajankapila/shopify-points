class Customer < ApplicationRecord
  belongs_to :shop

  def to_s
    "#{last_name}, #{first_name}"
  end
end
