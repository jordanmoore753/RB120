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

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARK = 'X'
  COMP_MARK = 'O'
  FIRST_TO_MOVE = HUMAN_MARK

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARK)
    @computer = Player.new(COMP_MARK)
    @curr_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        current_player_moves
        break if end_game?
        clear_screen_display_board if human_turn?
      end
      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts 'Welcome to TTT!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing TTT.'
  end

  def display_board
    puts "You're a #{human.marker} and opponent is #{computer.marker}."
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_display_board
    clear
    board.draw
  end

  def human_moves
    avail_moves = board.unmarked_keys
    puts "Choose a number: #{avail_moves.join(', ')}"
    square = nil

    loop do
      square = gets.chomp
      break if avail_moves.include?(square.to_i) && not_float?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square.to_i] = human.marker
  end

  def computer_moves
    avail_moves = board.unmarked_keys
    board[avail_moves.sample] = computer.marker
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

  def end_game?
    board.someone_won? || board.full?
  end
end

game = TTTGame.new
game.play
