# frozen_string_literal: true

module BoardGameGeek
  module Polls
    class Vote
      include ActiveModel::Model

      attr_accessor :title, :value
    end
  end
end
