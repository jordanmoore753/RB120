class Move
  attr_reader :value

  VALID_OPTIONS_HUMAN = ['r', 's', 'l', 'p', 'sc']
  VALID_OPTIONS_COMP = ['rock', 'scissors', 'lizard',
                        'spock', 'paper']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :points, :move_log

  def initialize
    @points = 0
    set_name
    @move_log = []
  end
end

class Human < Player
  SHORT_HAND = { 'r' => 'rock', 'sc' => 'scissors', 'l' => 'lizard',
                 's' => 'spock', 'p' => 'paper' }

  def set_name
    n = ''
    loop do
      puts 'What is your name?'
      n = gets.chomp.to_s
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil

    loop do
      puts "Pick rock (r), paper (p), spock (s), lizard (l), scissors (sc):"
      choice = gets.chomp
      break if Move::VALID_OPTIONS_HUMAN.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(SHORT_HAND[choice])
    move_log << move.value
  end
end

class Computer < Player
  def set_name
    self.name = ['C3P0', 'R2D2', 'Boba Fett', 'Hutt'].sample
  end

  def choose(opponent_log, win_moves)
    self.move = Move.new(select_move_from_log(opponent_log, win_moves))
    move_log << move.value
  end

  private

  def select_move_from_log(opp_log, winning_moves)
    move_rates = {}
    options = []

    opp_log.each do |val|
      move_rates[val] ? move_rates[val] += 1 : move_rates[val] = 1
    end

    highest_frequency_word = move_rates.max_by { |_, v| v }

    if check_ai_conditions(opp_log, highest_frequency_word)
      winning_moves.each do |k, _|
        options << k if winning_moves[k].include?(highest_frequency_word[0])
      end
      return options.sample
    end
    Move::VALID_OPTIONS_COMP.sample
  end

  def check_ai_conditions(log, highest)
    log.size > 6 && highest[1] >= (log.size / 2) + 2
  end
end

class RPSGame
  attr_accessor :human, :computer

  WIN_OPTIONS = { 'rock' => ['lizard', 'scissors'],
                  'paper' => ['rock', 'spock'],
                  'scissors' => ['paper', 'lizard'],
                  'lizard' => ['spock', 'paper'],
                  'spock' => ['rock', 'scissors'] }

  POINTS_TO_WIN = 10

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_msg

    loop do
      display_score
      human.choose
      computer.choose(human.move_log, WIN_OPTIONS)
      display_chosen_moves
      display_winner
      award_points
      break if end_game?
      break unless play_again?
      system 'clear'
    end
    ending_msg
    display_goodbye_msg
  end

  private

  def display_welcome_msg
    puts "Welcome to RPS!"
  end

  def display_goodbye_msg
    puts "Thanks for playing RPS!"
  end

  def display_chosen_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_tie
    puts 'Tie!'
  end

  def display_tie_points
    puts 'No points awarded.'
  end

  def check_winner?
    WIN_OPTIONS[human.move.value].include?(computer.move.value)
  end

  def display_winner
    return display_tie if human.move.value == computer.move.value

    if check_winner?
      puts "#{human.name} won!"
    else
      puts "#{computer.name} won!"
    end
  end

  def display_log
    puts "#{human.move_log}, #{computer.move_log}."
  end

  def award_points
    return display_tie_points if human.move.value == computer.move.value

    if check_winner?
      human.points += 1
    else
      computer.points += 1
    end
  end

  def display_score
    puts "#{human.name}: #{human.points}. #{computer.name}: #{computer.points}"
  end

  def end_game?
    human.points == POINTS_TO_WIN || computer.points == POINTS_TO_WIN
  end

  def ended_game_early_msg
    puts "It's a shame you have to go, #{human.name}."
  end

  def ending_msg
    return ended_game_early_msg if !end_game?

    if human_won?
      puts "#{human.name} won the game!"
    else
      puts "#{computer.name} won the game!"
    end
  end

  def human_won?
    human.points == POINTS_TO_WIN
  end

  def play_again?
    puts 'Would you like to play again? Y/N.'
    answer = ''

    loop do
      answer = gets.chomp.to_s
      answer.downcase!
      break if ['y', 'n'].include?(answer)
      puts 'Sorry, must be y or n.'
    end

    return true if answer == 'y'
    false
  end
end

RPSGame.new.play
