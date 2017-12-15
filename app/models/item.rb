class Item < ApplicationRecord
  belongs_to :user
  has_many :prices, dependent: :destroy
end
