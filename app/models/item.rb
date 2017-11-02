# frozen_string_literal: true

class Item < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum genre: {
    not_define: 0,
    abstract: 1,
    party: 2,
    euro: 3,
    war: 4,
    thematic: 5,
    family: 6,
    other: 99
  }

  # has_many :store_items, include: :store
  # has_many :stores, through: :store_items

  validates :name, presence: true
end
