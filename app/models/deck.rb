class Deck < Array
  VALUES = (1..12).to_a
  CARDS_PER_VALUE = 3

  def initialize
    super((VALUES * CARDS_PER_VALUE).shuffle)
  end
end
