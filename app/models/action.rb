class Action
  REVEAL_LOWEST = "reveal_lowest"
  REVEAL_HIGHEST = "reveal_highest"
  REVEAL_ON_TABLE = "reveal_on_table"

  def initialize(type:, entity_id:)
    @type = type
    @entity_id = entity_id
  end

  def apply
    entity.reveal
  end

  private

  def entity
    @entity ||=
      case @type
      when REVEAL_LOWEST
        Player.find(@entity_id).lowest_card
      when REVEAL_HIGHEST
        Player.find(@entity_id).highest_card
      when REVEAL_ON_TABLE
        Card.find(@entity_id)
      end
  end
end
