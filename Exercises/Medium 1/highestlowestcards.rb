class Card
  attr_reader :rank, :suit

  @@deck = []

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @@deck << [rank, suit]
  end

  def convert_royal(n)
    royals = ['Jack', 'Queen', 'King']

    case n 
    when 'Ace' then 11
    when royals.include?(n) then 10
    else
      n
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end



cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]

puts cards
