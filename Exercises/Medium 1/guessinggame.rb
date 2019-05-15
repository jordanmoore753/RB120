class GuessingGame
  MAX_GUESSES = 7
  attr_reader :number, :guesses

  def initialize
    @number = rand(100)
    @guesses = MAX_GUESSES
  end

  def play
    guess = nil

    until guesses.zero?
      display_guesses
      guess = enter_number
      break if evaluate_guess(guess)
      give_tip(guess)
      subtract_guess
    end

    display_results(guess)
  end

  def display_guesses
    puts "You have #{guesses} guesses remaining."
  end

  def enter_number
    answer = nil

    loop do 
      puts "Enter a number between 1 and 100: "
      answer = gets.chomp.to_i
      break if answer > 0 && answer < 101
      puts "Invalid guess."
    end

    answer
  end

  def evaluate_guess(num)
    num == number
  end

  def give_tip(num)
    if num < number
      puts "Your guess is too low."
    else 
      puts "Your guess is too high."
    end
    puts ""
  end

  def subtract_guess
    @guesses -= 1
  end

  def guesses_gone?
    guesses.zero?
  end

  def display_results(n)
    if n == number
      puts "That's the answer!"
      puts ""
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play
