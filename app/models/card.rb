class Card < ApplicationRecord
  HIDDEN_VALUE = "?"

  belongs_to :player, optional: true
  belongs_to :game

  scope :on_table, -> { where(player_id: nil) }
  scope :sorted, -> { order(value: :asc) }

  enum state: {
    hidden: 0,
    revealed: 1
  }

  def display_value
    return value if revealed?
    HIDDEN_VALUE
  end
end
