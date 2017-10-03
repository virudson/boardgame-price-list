# frozen_string_literal: true

module BoardGameGeek
  module Polls
    class Choice
      include ActiveModel::Model

      attr_accessor :numplayers, :value, :result
      attr_reader :votes

      def initialize(attributes = {})
        super(attributes)
        self.results = result.map { |vote| Vote.new(vote) }
      end

      def number_players
        self.numplayers&.to_i
      end
    end
  end
end
