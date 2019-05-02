module NameChange
  def name_change
    valid = ('a'..'z').to_a
    puts 'Choose your name. Use only letters, no whitespace or numbers.'
    answer = ''

    loop do 
      answer = gets.chomp.to_s

      break if answer.downcase.split('').all? { |letter| valid.include?(letter)}
      puts 'Invalid input: remember, no whitespace or numbers.'
    end

    puts "Player name is now: #{answer}."
    answer
  end
end

module Moves
  POSS_MOVES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def player_move(current_player)
    puts "Choose from the following: #{POSS_MOVES}."
    choice = ''

    loop do 
      choice = gets.chomp.to_s

      break if POSS_MOVES.include?(choice.downcase)
      puts "Invalid input: choose from the array of options."
    end

    puts "#{current_player} chooses #{choice}."
    choice
  end

  def computer_move
    choice = POSS_MOVES.sample
    puts choice
    choice
  end
end

class RPSGame
  include NameChange

  attr_accessor :human, :computer

  WIN_OPTIONS = { 'rock' => ['lizard', 'scissors'],
                   'paper' => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'lizard' => ['spock', 'paper'],
                   'spock' => ['rock', 'scissors'] }

  @@results = { "Player" => 0, "Computer" => 0 }

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    loop do 
      display_welcome_msg
      @human.name = name_change

      until winning_condition
        @human_choice = human.player_move(@human.name)
        @comp_choice = computer.computer_move
        increment_winner(compare(@human_choice, @comp_choice))
        display_results
      end

      display_results
      choice = play_again
      break if choice == 'n'

      reset_score
    end

  end

  def increment_winner(comparison)
    return 'No points awarded for tie.' if comparison == 'tie'
    comparison == 'player' ? @@results['Player'] += 1 : @@results['Computer'] += 1
  end

  def display_results
    puts "#{@human.name} score: #{@@results['Player']}. Computer score: #{@@results['Computer']}."
  end 

  def compare(move1, move2)
    return 'tie' if move1 == move2
    WIN_OPTIONS[move1].include?(move2) ? 'player' : 'computer'
  end 

  def winning_condition
    @@results['Player'] == 5 || @@results['Computer'] == 5
  end

  def play_again
    puts 'Play again? Y/N.'
    answer = ''

    loop do 
      answer = gets.chomp.to_s

      if answer.downcase == 'y' || answer.downcase == 'n' 
        break 
      else
        puts 'Try again: Y/N.'
      end
    end

    answer
  end

  def reset_score
    @@results = { "Player" => 0, "Computer" => 0 }
  end
end

class Player < RPSGame
  include Moves
  attr_accessor :name, :computer
  
  def initialize(name='')
    @player = ''
    @computer = 'Computer'
  end

  # def choose

  # end
end

# class Move < RPSGame
#   def initialize

#   end
# end

# class Rule < RPSGame
#   def initialize

#   end
# end

def display_welcome_msg
  puts 'Welcome to RPS!'
end

current = RPSGame.new
current.play
