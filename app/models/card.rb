class Card < ApplicationRecord
  validates :firstname,:lastname,:partner, presence: true
  validates :link, presence: true, format: { with: /\Ahttps?:\/\/\S+\z/ }

end
