class Notification < ApplicationRecord
  belongs_to :item
  monetize :old_price_cents
  monetize :new_price_cents
end
