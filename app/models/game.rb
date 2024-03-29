class Game < ApplicationRecord
  has_many :players, dependent: :delete_all
  has_many :cards, dependent: :delete_all

  enum state: {
    in_setup: 0,
    in_progress: 1,
    ended: 2
  }

  CARDS_PER_PLAYER_BY_COUNT = {
    3 => 9,
    4 => 7,
    5 => 6,
    6 => 5
  }

  def start
    ActiveRecord::Base.transaction do
      mark_in_progress
      deal_cards
      assign_first_user_turn
    end
  end

  def end_turn(current_player)
    ActiveRecord::Base.transaction do
      claim_trios_and_hide_mismatches(current_player)
      assign_next_player_turn
    end
  end

  def mismatch?(current_player)
    cards.revealed.pluck(:value).uniq.length > 1
  end

  def trio?(current_player)
    cards.revealed_or_playable_by(current_player.id).group_by(&:value).any? do |_, group|
      group.length == 3
    end
  end

  def reset!
    cards.map(&:hide)
  end

  private

  def claim_trios_and_hide_mismatches(current_player)
    cards.revealed_or_playable_by(current_player.id).group_by(&:value).each do |value, group|
      if group.length == 3
        group.map(&:win)
        current_player.scored
      else
        group.map(&:hide)
      end
    end
  end

  def revealed_cards
    cards.revealed
  end

  def mark_in_progress
    update(state: :in_progress)
  end

  def deal_cards
    deck = Deck.new

    players.each do |player|
      player.cards = deck.pop(CARDS_PER_PLAYER_BY_COUNT[players.count]).map do |value|
        Card.new(value: value, player: player, game: self)
      end
    end

    cards_on_table = deck.map do |value|
      Card.new(value: value, player: nil, game: self)
    end

    players.each(&:save)
    cards_on_table.map(&:save)
  end

  def assign_first_user_turn
    players.in_order.first.start_turn
  end

  def assign_next_player_turn
    active_turn_player = players.active_turn.first
    active_turn_player.end_turn

    if (active_turn_player == players.in_order.last)
      assign_first_user_turn
    else
      players.in_order[players.find_index(active_turn_player) + 1].start_turn
    end
  end
end
