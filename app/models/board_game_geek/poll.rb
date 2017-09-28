# frozen_string_literal: true

module BoardGameGeek
  class Poll
    include ActiveModel::Model

    attr_accessor :name, :title, :totalvotes, :results

    def initialize(attributes = {})
      super(attributes)
      self.results = if results.is_a?(Array)
                       results.map do |obj|
                         OpenStruct.new(obj).tab do |choice|
                           OpenStruct.new(choice.result)
                         end
                       end
                     else
                       binding.pry
                       results['result'].map { |obj| OpenStruct.new(obj) }
                     end
    end

    def total_votes
      @total_votes ||= totalvotes&.to_i
    end
  end
end
