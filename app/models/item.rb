class Item < ApplicationRecord
  belongs_to :user
  has_many :prices, dependent: :destroy
  monetize :price_cents
  monetize :user_price_cents, allow_nil: true
end
