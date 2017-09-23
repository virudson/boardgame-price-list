# frozen_string_literal: true

class Item < ApplicationRecord
  enum genre: {
    abstract: 0,
    party: 1,
    euro: 2,
    war: 3,
    thematic: 4,
    family: 5,
    other: 99
  }

  has_many :store_items, include: :store
  has_many :stores, through: :store_items

  validates :name, presence: true
end
