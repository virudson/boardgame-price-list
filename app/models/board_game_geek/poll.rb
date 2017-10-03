# frozen_string_literal: true

module BoardGameGeek
  class Poll
    include ActiveModel::Model

    attr_accessor :name, :title, :totalvotes, :results

    def initialize(attributes = {})
      super(attributes)
      # self.results =
    end

    def total_votes
      @total_votes ||= totalvotes&.to_i
    end
  end
end
