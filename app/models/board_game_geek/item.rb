# frozen_string_literal: true

module BoardGameGeek
  class Item
    include ActiveModel::Model

    attr_accessor :id, :type, :thumbnail, :image, :name, :description,
                  :yearpublished, :minplayers, :maxplayers, :poll, :playingtime,
                  :minplaytime, :maxplaytime, :minage, :link
    attr_reader :source

    alias_attribute :board_game_geek_id, :id

    def initialize(attributes = {})
      super(attributes)
      @name = name['value']
      @link = link.map { |obj| OpenStruct.new(obj) }
      @poll = poll.map { |obj| Poll.new(obj) }
      @source = attributes
    end

    def published_year
      @published_year ||= yearpublished['value']&.to_i
    end

    def min_players
      @min_players ||= minplayers['value']&.to_i
    end

    def max_player
      @max_players ||= maxplayers['value']&.to_i
    end

    def min_play_time
      @min_play_time ||= minplaytime['value']&.to_i
    end

    def max_play_time
      @max_play_time ||= maxplaytime['value']&.to_i
    end

    def min_age
      @min_age ||= minage['value']&.to_i
    end

    def categories
      @categories ||= link.select { |obj| obj.type == 'boardgamecategory' }
    end

    def publishers
      @publishers ||= link.select { |obj| obj.type == 'boardgamepublisher' }
    end

    def artists
      @artists ||= link.select { |obj| obj.type == 'boardgameartist' }
    end

    def to_params
      [
        name: name,
        thumbnail: thumbnail,
        image: image,
        min_players: min_players,
        max_players: max_players,
        min_play_time: min_play_time,
        max_play_time: max_play_time,
        min_age: min_age,
        release_date: Date.new(published_year, 1, 1),
        categories: categories.map(&:value),
        publishers: publishers.map(&:value),
        source_data: source,
      ]
    end
  end
end
