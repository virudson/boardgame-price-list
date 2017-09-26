# frozen_string_literal: true

module BoardingTime
  class Item < Shopify::Item
    def store_item_hash
      variant = variants.last
      {
        product_id: variant&.id,
        available: variant&.available,
        shipping: variant&.requires_shipping,
        price: variant&.price,
        weight: variant&.grams,
        source_data: source_data,
        latest_update_at: published_at
      }
    end

    def genre
      case product_type
      when 'Thematic' then :thematic
      when 'Family', 'Children' then :family
      when 'War' then :war
      when 'Strategy' then :euro
      else
        :other
      end
    end

    def item_hash
      {
        name: title,
        slug: handle,
        publisher: vendor,
        genre: genre
      }
    end

    private

    def formatted_source_data
      {

      }
    end
  end
end
