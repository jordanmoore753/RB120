#create a class called PokerHand
#initializes and takes 5 cards from deck as argument
#evaluates those cards and returns the relevant hand
#prints out the name of hand

class PokerHand
  attr_reader :hand

  def initialize(deck)
    @hand = []
    card = []

    5.times do 
      card = deck.draw
      @hand << card 
    end
  end

  def print

  end

  def sort_hand
    hand.sort
  end

  def straight_test
    hand_iter = sort_hand
  
    hand_iter.each_with_index do |card, idx|
      break if idx == hand_iter.size - 1 
      return false if card.value != hand_iter[idx + 1].value - 1
    end

    true
  end

  def flush_test
    hand_iter = sort_hand

    hand_iter.each_with_index do |card, idx|
      next if idx.zero?
      return false if card.suit != hand_iter[idx - 1].suit 
    end

    true
  end

  def first_is_royal?
    hand_iter = sort_hand

    hand_iter[0].rank == 10
  end

  def evaluate
    case 
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    first_is_royal? && straight_test && flush_test
  end

  def straight_flush?
    straight_test && flush_test
  end

  def four_of_a_kind?
    hand_iter = sort_hand
    
    hand_iter.each_with_index do |card, idx|
      break if idx == (hand_iter.size - 2)
      return true if card.rank == hand_iter[idx + 1].rank && card.rank == hand_iter[idx + 2].rank && card.rank == hand_iter[idx + 3].rank
    end

    false
  end

  def full_house?
    hand_iter = sort_hand
    one_pair, idx = nil, 0 

    hand_iter.each_with_index do |card, idx|
      break if idx == (hand_iter.size - 2)
      if card.rank == hand_iter[idx + 1].rank && card.rank == hand_iter[idx + 2].rank
        one_pair = true
        delete_this = idx
        break
      end
    end

    if one_pair
      3.times { hand_iter.delete_at(idx) }
    else
      return false
    end

    hand_iter.each_with_index do |card, idx|
      break if idx == hand_iter.size - 1
      return true if card.rank == hand_iter[idx + 1].rank 
    end

    false
  end

  def flush?
    flush_test
  end

  def straight?
    straight_test
  end

  def three_of_a_kind?
    hand_iter = sort_hand
    
    hand_iter.each_with_index do |card, idx|
      break if idx == (hand_iter.size - 2)
      return true if card.rank == hand_iter[idx + 1].rank && card.rank == hand_iter[idx + 2].rank
    end

    false
  end

  def two_pair?
    hand_iter = sort_hand
    one_pair, delete_this = nil, 0 

    hand_iter.each_with_index do |card, idx|
      break if idx == (hand_iter.size - 1)
      if card.rank == hand_iter[idx + 1].rank
        one_pair = true
        delete_this = idx
        break
      end
    end

    if one_pair
      2.times { hand_iter.delete_at(delete_this) }
    else
      return false
    end

    hand_iter.each_with_index do |card, idx|
      next if idx == (hand_iter.size - 1)
      return true if card.rank == hand_iter[idx + 1].rank
    end

    false
  end

  def pair?
    hand_iter = sort_hand
    
    hand_iter.each_with_index do |card, idx|
      break if idx == (hand_iter.size - 1)
      return true if card.rank == hand_iter[idx + 1].rank
    end

    false
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])

puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])

puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])

puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])

puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])

puts hand.evaluate == 'High card'