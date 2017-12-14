class User < ApplicationRecord
  belongs_to :registration
  has_many :items
  has_attachment :photo

end
