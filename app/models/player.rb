class Player < ApplicationRecord
  belongs_to :game
  has_many :cards

  def sorted_cards
    cards.sorted
  end

  def lowest_card
    sorted_cards.first
  end

  def highest_card
    sorted_cards.last
  end
end
