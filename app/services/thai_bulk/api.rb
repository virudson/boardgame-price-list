module ThaiBulk
  class Api
    API_URL = ENV['THAI_BULK_API_URL'] || Settings.THAI_BULK_API_URL
    DEFAULT_PARAMS = {         
      username: ENV['THAI_BULK_USERNAME'] || Settings.THAI_BULK_USERNAME,
      password: ENV['THAI_BULK_PASSWORD'] || Settings.THAI_BULK_PASSWORD 
    }.freeze
    
    def self.check_balance(params = {})
      warn 'WARNING: THAIBULK.COM API '\
           'always return `Unable to check credit balance`'
      params[:tag] ||= 'credit_remain'
      call_api(params)
    end

    def self.send_sms(params = {})
      call_api(params)
    end
    
    def self.call_api(params = {})
      response = RestClient.post API_URL, DEFAULT_PARAMS.merge(params)
      Hash.
        from_xml(response.body).
        deep_transform_keys { |key| key.underscore.to_sym }
    end
  end
end
