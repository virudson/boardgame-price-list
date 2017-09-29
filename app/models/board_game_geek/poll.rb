# frozen_string_literal: true

module BoardGameGeek
  class Poll
    include ActiveModel::Model

    attr_accessor :name, :title, :totalvotes, :results

    def initialize(attributes = {})
      super(attributes)
      self.results = if results.is_a?(Array)
                       results.map do |obj|
                         poll = OpenStruct.new(obj).tab |pol|
                         poll.result = poll.result.map do |vote|
                           OpenStruct.new(vote)
                         end
                         poll
                       end
                     else
                       results['result'].map { |obj| OpenStruct.new(obj) }
                     end
    end

    def total_votes
      @total_votes ||= totalvotes&.to_i
    end
  end
end
