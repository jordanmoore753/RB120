class Card
  include Comparable

  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}."
  end

  # def <=>(other)
  #   value <=> other.value
  # end

  def value
    VALUES.fetch(@rank, @rank)
  end
end

class Deck
  attr_reader :cards 

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def reset
    @cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
  end

  def draw
    reset if @cards.empty?
    @cards.pop
  end

  # def create_deck
  #   rank_counter, suit_counter = 0, 0

  #   until cards.size == 52
  #     4.times do 
  #       cards << Card.new(RANKS[rank_counter], SUITS[suit_counter])
  #       suit_counter += 1
  #     end

  #     suit_counter = 0
  #     rank_counter += 1
  #   end
  # end

  # def draw
  #   if cards.size.zero?
  #     create_deck
  #     puts "Deck dealt again."
  #   else
  #     new_card = cards.sample
  #     new_idx = cards.index(new_card)
  #     cards.delete_at(new_idx)
  #   end
  # end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2