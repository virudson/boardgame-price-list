# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :store_items, include: :item
  has_many :items, through: :store_items

  validates :name, presence: true
end
