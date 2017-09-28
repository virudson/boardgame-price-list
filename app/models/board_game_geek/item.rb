# frozen_string_literal: true

module BoardGameGeek
  class Item
    include ActiveModel::Model

    attr_accessor :id, :type, :thumbnail, :image, :name, :description,
                  :yearpublished, :minplayers, :maxplayers, :poll, :playingtime,
                  :minplaytime, :maxplaytime, :minage, :link

    def initialize(attributes = {})
      super(attributes)
      self.name = name['value']
      self.link = link.map { |obj| OpenStruct.new(obj) }
      self.poll = poll.map { |obj| Poll.new(obj) }
    end

    def publish_year
      @publish_year ||= yearpublished['value']&.to_i
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
  end
end
