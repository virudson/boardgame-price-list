# frozen_string_literal: true

module BoardgameGeek
  class Api
    MAX = 250_000
    STEP = 500
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
      write_to_file(items)
    end

    def fetch
      item_count.step(MAX, STEP) do |id|
        if response = fetch_from_source(id, id + STEP)
          # @items << response
          write_to_file(response)
        end
        self.item_count += STEP
      end
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
      "#{store_name}-[#{item_count}-#{item_count + STEP}].json"
    end

    def file_path
      File.join(save_file_path, filename)
    end

    private

    def fetch_from_source(id, gap)
      types = %w[boardgame boardgameexpansion boardgameaccessory].join(',')
      print "Fetch from #{api_url}/[#{id}-#{gap}]..."
      id_query = (id..gap).to_a.join(',')
      response = RestClient.get(api_url, params: { id: id_query, type: types })
      data = Hash.from_xml(response).dig('items', 'item')
      puts data.present? ? "FOUND #{data.size} records!" : 'NOT FOUND!'
      data || {}
    end

    def write_to_file(item)
      File.open(file_path, 'w') do |f|
        f.write JSON.pretty_generate(item)
      end
    end
  end
end
