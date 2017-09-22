# frozen_string_literal: true

class StoreItem < ApplicationRecord
  belongs_to :store
  belongs_to :item

  monetize :price_satangs
end
