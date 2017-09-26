# frozen_string_literal: true

module BoardingTime
  class Bot < Shopify::Api
    def initialize
      super(
        host: Settings.boarding_time.api_host,
        store_name: Settings.boarding_time.store_name
      )
    end
  end
end