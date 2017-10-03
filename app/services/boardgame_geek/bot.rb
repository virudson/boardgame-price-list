# frozen_string_literal: true

module BoardgameGeek
  class Bot < BoardgameGeek::Api
    def initialize
      super(
        host: Settings.boardgame_geek.api_host,
        store_name: Settings.boardgame_geek.store_name,
        item_count: 0
      )
    end
  end
end
