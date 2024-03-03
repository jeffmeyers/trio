class Player < ApplicationRecord
  belongs_to :game
  has_many :cards

  scope :in_order, -> { order(id: :asc) }
  scope :active_turn, -> { where(active_turn: true) }

  def scored
    update(score: score + 1)
  end

  def start_turn
    update(active_turn: true)
  end

  def end_turn
    update(active_turn: false)
  end

  def sorted_cards
    cards.sorted
  end

  def lowest_card
    sorted_cards.first
  end

  def highest_card
    sorted_cards.last
  end

  def has_card?(value)
    cards.pluck(:value).include?(value)
  end
end
