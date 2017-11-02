# frozen_string_literal: true

module BoardgameGeek
  class Api
    AVAILABLE_TYPES = %w(boardgame boardgameexpansion).freeze
    HOST = 'www.boardgamegeek.com'
    PATH = '/xmlapi2/thing'
    URL = URI::HTTPS.build(host: HOST, path: PATH).to_s

    def self.all(id, limit, opts = {})
      types = AVAILABLE_TYPES.join(',')
      id_query = (id..limit).to_a.join(',')

      print "Fetch from #{URL}/[#{id}-#{limit}]..."
      response = RestClient.get(URL, params: { id: id_query, type: types })

      data = Hash.from_xml(response).dig('items', 'item')
      puts data.present? ? "FOUND #{data.size} records!" : 'NOT FOUND!'
      write_to_file(data, id, limit) if opts.delete(:save_to_file)
      puts 'In Progress' if opts.delete(:save_to_db)
      data || {}
    end

    private_class_method def self.write_to_file(item, id, limit)
      save_path = Rails.root.join(Settings.sources.raw_dir, 'games')
      filename = "#{id}-#{limit}.json"
      FileUtils.mkdir_p(save_path)

      File.open(File.join(save_path, filename), 'w') do |f|
        f.write JSON.pretty_generate(item)
      end
    end
  end
end
