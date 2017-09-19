# frozen_string_literal: true

module Bdt
  class Bot
    SOURCE_URL = 'https://boardingtimegames.com/products.json'
    RAW_DIR = Settings.sources.raw_dir

    attr_accessor :items, :page

    def initialize
      @page = 1
    end

    def perform
      fetch unless items
      write_to_file(items)
    end

    def fetch
      self.items ||= begin
        result = []
        loop do
          response = fetch_from_source(page)
          self.page += 1
          result += response
          break if response.empty?
        end
        result
      end
    end


    private

    def fetch_from_source(page)
      response = RestClient.get(SOURCE_URL, params: { page: page, limit: 250 })
      JSON.parse(response.body).dig('products')
    end

    def write_to_file(data)
      date = Date.today
      filename = "bdt-#{date}.json"
      save_file_path = Rails.root.join(RAW_DIR, 'bdt', filename)
      File.open(save_file_path, 'w') { |f| f.write JSON.pretty_generate(data) }
    end
  end
end