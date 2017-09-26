# frozen_string_literal: true

module BoardgameGeek
  class Api
    attr_accessor :host, :store_name, :item_count
    attr_reader :items

    def initialize(host:, store_name:, item_count: 1)
      @host = host
      @store_name = store_name
      @item_count = item_count
    end

    def save_to_file!
      FileUtils.mkdir_p(save_file_path)
      fetch unless items
      write_to_file
    end

    def fetch
      return @items if item_count == 50
      @items ||= []
      item_count.upto(50) do |id|
        response = fetch_from_source(id)
        @items << response if response
      end
      @items
    rescue StandardError => e
      puts e
      (1..5).to_a.reverse.each do |i|
        puts "Retrying in... #{i}"
        sleep 1
      end
      retry
    end

    def api_url
      "#{host}/xmlapi2/thing"
    end

    def save_file_path
      Rails.root.join(Settings.sources.raw_dir, store_name)
    end

    def filename
      "#{store_name}-#{item_count}-#{Date.today}.json"
    end

    def file_path
      File.join(save_file_path, filename)
    end

    private

    def fetch_from_source(id)
      types = %w[boardgame boardgameexpansion boardgameaccessory].join(',')
      print "Fetch from #{api_url}/#{id}... "
      response = RestClient.get(api_url, params: { id: id, type: types })
      data = Hash.from_xml(response).dig('items', 'item')
      puts data ? 'OK!' : 'NOT FOUND!'
      data || {}
    end

    def write_to_file
      File.open(file_path, 'w') do |f|
        f.write JSON.pretty_generate(items)
      end
    end
  end
end
