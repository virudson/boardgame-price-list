# frozen_string_literal: true

module ThaiBulk
  class SendSms
    include ActiveModel::Model

    MOBILE_REGEXP = /\A0\d{9}\z/

    attr_accessor :phone_number, :message, :sender, :send_at
    attr_reader :result

    validates_presence_of :message, :phone_number, :sender
    validates_format_of :phone_number,
                        with: MOBILE_REGEXP,
                        allow_blank: true,
                        unless: :send_multiple?

    validate :multi_number_format_validates, if: :send_multiple?

    def perform
      raise_error unless valid?
      response = Api.send_sms(sms_params).dig(:sms, :queue)
      @result = begin 
        if send_multiple?
          response.map { |queue| Queue.new(queue) } 
        else
          Queue.new(response)
        end
      end
    end

    def send_multiple?
      phone_number.is_a?(Array) && phone_number.size > 1
    end

    private def sms_params
      params = {
        msisdn: send_multiple? ? phone_number.join(',') : phone_number,
        message: message
      }
      params[:ScheduledDelivery] = send_at.strftime('%y%M%d%H%M') if send_at
      params
    end

    private def multi_number_format_validates
      phone_number.each do |str|
        errors.add(:phone_number, :invalid) && return if !(str =~ MOBILE_REGEXP)
      end
    end

    private def raise_error
      msg = errors.full_messages.join("\n")
      raise ActiveModel::MissingAttributeError.new(msg)
    end
  end
end
