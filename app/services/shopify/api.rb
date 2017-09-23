# frozen_string_literal: true

module Shopify
  class Api
    attr_accessor :host, :store_name
    attr_reader :items, :total_page

    def initialize(host:, store_name:)
      @host = host
      @store_name = store_name
      @total_page = 1
    end

    def save_to_file!
      FileUtils.mkdir_p(save_file_path)
      fetch unless items
      write_to_file(items)
    end

    def fetch
      @items ||= begin
        result = []
        loop do
          response = fetch_from_source(total_page)
          @total_page += 1
          result += response
          break if response.empty?
        end
        result
      end
    end

    def api_url
      "#{host}/products.json"
    end

    def save_file_path
      Rails.root.join(Settings.sources.raw_dir, store_name)
    end

    def filename
      "#{store_name}-#{Date.today}.json"
    end

    def file_path
      File.join(save_file_path, filename)
    end


    private

    def fetch_from_source(page)
      response = RestClient.get(api_url, params: { page: page, limit: 250 })
      JSON.parse(response.body).dig('products')
    end

    def write_to_file(data)
      File.open(file_path, 'w') do |f|
        f.write JSON.pretty_generate(data)
      end
    end
  end
end