# frozen_string_literal: true

module BattlefieldBkk
  class Bot < Shopify::Api
    def initialize
      super(
        host: Settings.battlefield_bangkok.api_host,
        store_name: Settings.battlefield_bangkok.store_name
      )
    end
  end
end