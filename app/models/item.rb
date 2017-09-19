# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :store_items, include: :store
  has_many :stores, through: :stores

  validates :name, presence: true
end
