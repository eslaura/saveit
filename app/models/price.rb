class Price < ApplicationRecord
  belongs_to :item
  monetize :price_cents

end
