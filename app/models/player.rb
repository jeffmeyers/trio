class Player < ApplicationRecord
  belongs_to :game
  has_many :cards

  def sorted_cards
    cards.sorted
  end
end
