class Card < ApplicationRecord
  HIDDEN_VALUE = "Reveal"

  belongs_to :player, optional: true
  belongs_to :game

  scope :on_table, -> { where(player_id: nil) }
  scope :sorted, -> { order(value: :asc).in_play }
  scope :revealed, -> { where(state: :revealed) }
  scope :revealed_or_playable_by, ->(player_id) { revealed.or(playable_by(player_id)).in_play }
  scope :playable_by, ->(player_id) { owned_by(player_id).where(value: [min_for(player_id), max_for(player_id)]) }
  scope :min_for, ->(player_id) { owned_by(player_id).pluck(:value).min }
  scope :max_for, ->(player_id) { owned_by(player_id).pluck(:value).max }
  scope :owned_by, ->(player_id) { where(player_id: player_id) }
  scope :in_play, -> { where.not(state: :won) }

  enum state: {
    hidden: 0,
    revealed: 1,
    won: 2
  }

  def display_value
    return value if revealed?
    return "Won #{value}" if won?
    HIDDEN_VALUE
  end

  def reveal
    update(state: :revealed)
  end

  def hide
    update(state: :hidden)
  end

  def win
    update(state: :won)
  end
end
