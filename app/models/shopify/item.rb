# frozen_string_literal: true

module Shopify
  class Item
    include ActiveModel::Model

    attr_accessor :id, :title, :handle, :vendor, :product_type, :body_html,
                  :tags, :images, :variants, :options, :source_data,
                  :published_at, :created_at, :updated_at

    def initialize(attributes = {})
      super(attributes)
      self.source_data = attributes
      self.images = images.map { |image| Image.new(image) }
      self.variants = variants.map { |image| Variant.new(image) }
      self.published_at = Time.parse(published_at)
      self.created_at = Time.parse(created_at)
      self.updated_at = Time.parse(updated_at)
    end
  end
end
