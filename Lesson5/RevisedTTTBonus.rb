class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset_board
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
    puts "|     |     |     |"
    puts "|  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  |"
    puts "|     |     |     |"
    puts "+-----+-----+-----+"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def joinor(arr, punct1 = ', ', punct2 = 'or')
    return arr.join if arr.size < 2
    if arr.size == 2
      arr = arr.join(' or ')
      arr + '.'
    else
      arr1 = arr.slice(-arr.size..-1).join(punct1)
      arr2 = arr1.slice!(-1)
      arr1 + punct2 + ' ' + arr2 + '.'
    end
  end

  def set_square_at(key, mark)
    @squares[key].marker = mark
  end

  def unmarked_keys
    @squares.keys.select { |k| @squares[k].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def ai_strategy
    return 5 if five_unmarked?
    return ai_offense if !ai_offense.nil?
    return ai_defense if !ai_defense.nil?
    nil
  end

  def five_unmarked?
    @squares[5].marker == Square::INITIAL_MARKER
  end

  def ai_offense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if win_mark?(squares)
        return find_mark(squares, line)
      end
    end
    nil
  end

  def ai_defense
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if weak_mark?(squares)
        return find_mark(squares, line)
      end
    end
    nil
  end

  def weak_mark?(squares)
    human_markers = squares.select(&:human_marked?).collect(&:marker)
    unmarked_markers = squares.select(&:unmarked?).collect(&:marker)
    return false if human_markers.size != 2 || unmarked_markers.size != 1

    true
  end

  def find_mark(squares, lines)
    counter = 0

    until counter > 2
      break if squares[counter].marker == Square::INITIAL_MARKER
      counter += 1
    end

    lines[counter]
  end

  def win_mark?(squares)
    comp_markers = squares.select(&:computer_marked?).collect(&:marker)
    unmarked_markers = squares.select(&:unmarked?).collect(&:marker)
    return false if comp_markers.size != 2 || unmarked_markers.size != 1

    true
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def reset_board
    (1..9).each { |num| @squares[num] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def to_s
    @marker
  end

  def human_marked?
    marker == TTTGame::HUMAN_MARK
  end

  def computer_marked?
    marker == TTTGame::COMP_MARK
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :points
  attr_accessor :name

  def initialize(marker, name = 'Computer')
    @marker = marker
    @points = 0
    @name = name
  end

  def add_point
    @points += 1
  end
end

class TTTGame
  HUMAN_MARK = ''
  COMP_MARK = 'O'
  FIRST_TO_MOVE = ''
  MAX_POINTS = 5
  INVALID_MARKER = ['O', 'o', '0', '', ' ']
  COMP_NAME_OPTIONS = ['Boba Fett', 'Jabba', 'C3P0']

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK, 'Human')
    @computer = Player.new(COMP_MARK, COMP_NAME_OPTIONS.sample)
    @curr_marker = HUMAN_MARK
  end

  def play
    display_welcome_and_choices

    loop do
      display_board

      loop do
        current_player_moves
        break if end_current_game?
        clear_screen_display_board if human_turn?
      end
      award_points
      end_current_game_display

      break if end_match?
      break unless play_again?
      reset
    end
    end_match_display
  end

  private

  def display_welcome_and_choices
    display_welcome_message
    choose_name(human)
    choose_marker
    choose_turn_order
  end

  def display_welcome_message
    clear
    puts 'Welcome to TTT!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing TTT.'
  end

  def display_board
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts "#{human.name}'s marker: '#{human.marker}'."
    puts "#{computer.name}'s marker: '#{computer.marker}'."
    puts "Points to win entire match: #{MAX_POINTS}."
    display_points
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts ''
    board.draw
    puts ''
  end

  def display_points
    puts "#{human.name}: #{human.points}. #{computer.name}: #{computer.points}."
  end

  def display_winner
    if end_match?
      puts "#{human.name} wins!" if human_won?
      puts "#{computer.name} wins!" if computer_won?
    else
      puts "It's a shame you need to leave early, #{human.name}!"
    end
  end

  def end_current_game_display
    display_result
    display_points
  end

  def end_match_display
    display_winner
    display_goodbye_message
  end

  def choose_marker
    puts "#{human.name}, choose your one-character marker."
    puts "It may not be: #{board.joinor(INVALID_MARKER[0, 3])}"
    answer = nil

    loop do
      answer = gets.chomp
      break unless INVALID_MARKER.include?(answer) || answer.length > 1
      puts "Sorry, that's not a valid marker."
    end

    HUMAN_MARK.replace(answer)
  end

  def choose_turn_order
    puts 'Would you like to go first? Y/N:'
    answer = nil

    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, answer must be y or n."
    end

    if answer == 'n'
      @curr_marker = COMP_MARK
      FIRST_TO_MOVE.replace(COMP_MARK)
    else
      FIRST_TO_MOVE.replace(HUMAN_MARK)
    end
  end

  def choose_name(player)
    n = ''

    loop do
      puts "What is your name, #{player.name}?"
      n = gets.chomp.to_s
      break unless n.empty? || n == ' '
      puts 'Sorry, you must enter a value.'
    end
    player.name = n
  end

  def clear_screen_display_board
    clear
    display_board
  end

  def human_moves
    avail_moves = board.unmarked_keys
    puts "Choose a number: #{board.joinor(avail_moves)}"
    square = nil

    loop do
      square = gets.chomp
      break if avail_moves.include?(square.to_i) && not_float?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square.to_i] = human.marker
  end

  def computer_moves
    poss_move = board.ai_strategy
    avail_moves = board.unmarked_keys

    if poss_move.is_a? Integer
      board[poss_move] = computer.marker
    else
      board[avail_moves.sample] = computer.marker
    end
  end

  def not_float?(num)
    num != num.to_f.to_s
  end

  def display_result
    clear_screen_display_board

    case board.winning_marker
    when human.marker
      puts 'Player won.'
    when computer.marker
      puts 'Computer won.'
    else
      puts "Board is full."
    end
  end

  def award_points
    case board.winning_marker
    when human.marker
      human.add_point
    when computer.marker
      computer.add_point
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @curr_marker = COMP_MARK
    else
      computer_moves
      @curr_marker = HUMAN_MARK
    end
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again? Y/N:'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts 'Sorry, answer must be y or n.'
    end

    answer == 'y' ? true : false
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset_board
    @curr_marker = FIRST_TO_MOVE
    clear
    puts "Let's play again."
    puts ''
  end

  def human_turn?
    @curr_marker == HUMAN_MARK
  end

  def end_current_game?
    board.someone_won? || board.full?
  end

  def human_won?
    human.points == MAX_POINTS
  end

  def computer_won?
    computer.points == MAX_POINTS
  end

  def end_match?
    human_won? || computer_won?
  end
end

game = TTTGame.new
game.play
