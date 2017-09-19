# frozen_string_literal: true

module Bdt
  class Image
    include ActiveModel::Model

    attr_accessor :id, :product_id, :position, :variant_ids, :src,
                  :width, :height, :created_at, :updated_at

    def initialize(attr = {})
      super(attr)
      self.created_at = Time.parse(created_at)
      self.updated_at = Time.parse(updated_at)
    end
  end
end
