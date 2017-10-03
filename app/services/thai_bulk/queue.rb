# frozen_string_literal: true

module ThaiBulk
  class Queue
    include ActiveModel::Model
    
    attr_accessor :msisdn, :status, :transaction, :used_credit, :remain_credit

    def initialize(attributes = {})
      super(attributes)
      self.used_credit = used_credit.to_f
      self.remain_credit = remain_credit.to_f
    end

    def success?
      status == '1'
    end

    def failure?
      status == '0'
    end

    def to_h
      if success?
        {
          msisdn: msisdn,
          status: 'success',
          transaction: transaction,
          used_credit: used_credit,
          remain_credit: remain_credit
        }
      else
        { status: 'failure', detail: detail }
      end
    end
  end
end
