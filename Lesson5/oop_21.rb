module Participant
  attr_reader :hand_value, :hand
  attr_accessor :wins, :name

  def hit(cards)
    hand << cards.draw_card
  end

  def stay?
    answer = nil

    loop do
      puts "Hit(h) or Stay(s)?"
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)
      puts 'Sorry, please type h or s.'
    end

    answer == 's' ? true : false
  end

  def busted?
    @hand_value > TwentyOne::WIN_VALUE
  end

  def total
    @hand_value = 0

    hand.each do |card|
      @hand_value += if card.value == 'Ace'
                       11
                     elsif card.value.to_i == 0
                       10
                     else
                       card.value.to_i
                     end
    end
  end

  def over_win_value?
    @hand_value > TwentyOne::WIN_VALUE
  end

  def reduce_total_ace_value
    ace_total = 0
    hand.each { |card| ace_total += 1 if card.value == 'Ace' }
    ace_total.times { @hand_value -= 10 } if over_win_value?
  end

  def pre_results_total
    total
    reduce_total_ace_value
  end

  def card_values
    hand.map(&:value)
  end

  def difference_from_win_value
    @hand_value = TwentyOne::WIN_VALUE - @hand_value
  end

  def reset_hand_and_value
    @hand = []
    @hand_value = 0
  end
end

class Player
  include Participant

  def initialize
    @name = 'Jondan'
    @hand = []
    @hand_value = 0
    @wins = 0
  end
end

class Dealer
  include Participant

  def initialize
    @name = 'Dealer'
    @hand_value = 0
    @wins = 0
    @hand = []
  end

  def stay?
    pre_results_total
    TwentyOne::DEALER_STAY_RANGE.include?(@hand_value)
  end

  def first_card
    card_values.first
  end
end

class Deck
  SUITS = ['H', 'S', 'D', 'C']
  VALUES = ['2', '3', '4', '5', '6',
            '7', '8', '9', '10', 'J',
            'Q', 'K', 'A']

  attr_reader :deck

  def initialize
    @deck = []
    fill_deck
  end

  def fill_deck
    @deck = []
    value_count = 0

    13.times do
      SUITS.each { |suit| @deck << Card.new(suit, VALUES[value_count]) }
      value_count += 1
    end
  end

  def draw_card
    new_card = @deck.sample
    deck.delete_at(deck.index(new_card))
    new_card
  end
end

class Card
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def value
    case @value
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else @value
    end
  end
end

class TwentyOne
  WIN_VALUE = 21
  DEALER_MIN_STAY = WIN_VALUE - 4
  DEALER_STAY_RANGE = (DEALER_MIN_STAY..WIN_VALUE).to_a
  POINTS_TO_WIN = 5
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    choose_name
    loop do
      start_of_round_actions

      loop do
        display_wins_and_cards
        player.stay? ? break : player_turn
        break if player.busted?
      end

      loop do
        dealer_turn_over? ? break : dealer_turn
      end

      end_of_round_actions
      break if someone_won? || not_play_again?
    end
    display_ending_message
  end

  private

  def display_initial_cards
    puts "#{player.name}'s cards: #{player.card_values}"
  end

  def display_wins_and_cards
    clear
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    display_wins
    puts ''
    display_current_cards
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def display_current_cards
    puts "#{player.name}'s cards: #{player.card_values}."
    puts "#{dealer.name}'s first card is: #{dealer.first_card}."
  end

  def display_wins
    puts "#{player.name}'s win total: #{player.wins}."
    puts "#{dealer.name}'s win total: #{dealer.wins}."
  end

  def display_ending_message
    if player_won_match?
      puts "#{player.name} won the match."
    elsif dealer_won_match?
      puts "#{dealer.name} won the match."
    else
      puts "Come back soon, #{player.name}!"
    end
    puts "Thank you for playing 21."
  end

  def display_results
    display_wins_and_cards
    if either_busted?
      display_busted
    elsif tie?
      msg_format("Tie.")
    else
      display_winner
    end
  end

  def display_busted
    if player.busted?
      msg_format("#{player.name} busts. #{dealer.name} wins!")
    elsif dealer.busted?
      msg_format("#{dealer.name} busts. #{player.name} wins!")
    end
  end

  def display_winner
    if player_won?
      msg_format("#{player.name} wins!")
    else
      msg_format("#{dealer.name} wins!")
    end
  end

  def deal_cards
    2.times do
      player.hit(deck)
      dealer.hit(deck)
    end
  end

  def clear
    system 'clear'
  end

  def msg_format(message)
    puts "*** #{message} ***"
  end

  def start_of_round_actions
    reset
    deal_cards
    display_initial_cards
  end

  def end_of_round_actions
    compute_winner
    display_results
    award_points
  end

  def choose_name
    clear
    n = ''

    loop do
      puts "What is your name, human?"
      n = gets.chomp.to_s
      break unless n.empty? || n == ' '
      puts 'Sorry, you must enter a value.'
    end
    player.name = n
  end

  def player_turn
    player.hit(deck)
    player.total
    player.reduce_total_ace_value
  end

  def dealer_turn
    dealer.hit(deck)
    dealer.total
    dealer.reduce_total_ace_value
  end

  def dealer_turn_over?
    dealer.stay? || either_busted?
  end

  def compute_winner
    display_current_cards
    compute_final_hand_value if neither_busted?
  end

  def compute_final_hand_value
    player.pre_results_total
    dealer.pre_results_total
    player.difference_from_win_value
    dealer.difference_from_win_value
  end

  def player_won?
    player.hand_value < dealer.hand_value
  end

  def tie?
    player.hand_value == dealer.hand_value
  end

  def neither_busted?
    !player.busted? && !dealer.busted?
  end

  def either_busted?
    player.busted? || dealer.busted?
  end

  def award_points
    if player.busted?
      dealer.wins += 1
    elsif dealer.busted?
      player.wins += 1
    elsif tie?
      puts "No points awarded for tie."
    elsif player_won?
      player.wins += 1
    else
      dealer.wins += 1
    end
  end

  def not_play_again?
    answer = nil

    loop do
      puts 'Would you like to play again? Y/N:'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts 'Sorry, answer must be y or n.'
    end

    answer == 'n' ? true : false
  end

  def reset
    player.reset_hand_and_value
    dealer.reset_hand_and_value
    deck.fill_deck
  end

  def player_won_match?
    player.wins == POINTS_TO_WIN
  end

  def dealer_won_match?
    dealer.wins == POINTS_TO_WIN
  end

  def someone_won?
    player_won_match? || dealer_won_match?
  end
end

TwentyOne.new.start
