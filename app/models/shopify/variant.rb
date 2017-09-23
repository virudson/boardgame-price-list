# frozen_string_literal: true

module Shopify
  class Variant
    include ActiveModel::Model

    attr_accessor :id, :product_id, :title, :position, :sku, :requires_shipping,
                  :option1, :option2, :option3, :taxable, :featured_image,
                  :available, :price, :grams, :compare_at_price, :position,
                  :created_at, :updated_at

    def initialize(attr = {})
      super(attr)
      self.price = Money.from_amount(price.to_f)
      self.created_at = Time.parse(created_at)
      self.updated_at = Time.parse(updated_at)
    end
  end
end
