class User < ApplicationRecord
  belongs_to :registration
  has_many :items
end
