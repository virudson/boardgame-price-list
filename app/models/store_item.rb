# frozen_string_literal: true

class StoreItem < ApplicationRecord
  enum state: { not_available: 0, preorder: 1 }

  belongs_to :store
  belongs_to :item

  monetize :price_satangs
end
