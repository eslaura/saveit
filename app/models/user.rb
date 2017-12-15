class User < ApplicationRecord
  belongs_to :registration
  has_many :items, dependent: :destroy
  has_attachment :photo

end
