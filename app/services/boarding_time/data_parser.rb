# frozen_string_literal: true

module BoardingTime
  class DataParser
    FORMATTED_DIR = Settings.sources.formatted_dir
    RAW_DIR = Settings.sources.raw_dir

    include ActiveModel::Model

    attr_accessor :date, :filename, :file_path, :save_file_path

    validates :date, presence: true

    def initialize(attributes = {})
      super(attributes)
      @date = Date.today if Rails.env.development?
      @filename = "bdt-#{date}.json"
      @file_path = Rails.root.join(RAW_DIR, 'bdt', filename)
      @save_file_path = Rails.root.join(FORMATTED_DIR, filename)
    end

    def write_formatted_file
      File.open(save_file_path, 'w') do |f|
        f.write JSON.pretty_generate(formatted_data)
      end
    end

    def items
      @items ||= begin
        JSON.parse(File.read(file_path)).map do |data|
          item = Item.new(data)
          item unless item.product_type == 'Sleeve'
        end.compact
      end
    end


    private

    def formatted_item_data(item)
      {
        name: item.dig('image:image', 'image:loc'),
        image_url: item.dig('image:image', 'image:title')
      }
    end
  end
end
