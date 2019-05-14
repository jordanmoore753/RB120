=begin 

input = string
output = string
rules = using the instance methods given,
        create the instance methods that will
        output the example shown. All instance methods
        used must be private.

algorithm=
- create Banner class, 
- initialize @message = message
- also initialize a var named length that's equal to
- the length of @message + 2
- define method named horizontal rule
  - + symbol on each side of sentence, star * , - length for amount
  of - between them
- empty line method
  - | on first char, | on last, between is ' ' * length of input string
  define message_line method
  - start with | and end with |
  - a ' ', then + input string, then + ' '
define the to_s method
  - joins horizontal rule, empty line, message line, empty, horizontal
  with a /n to create a new line.

=end

class Banner
  attr_reader :message, :length

  def initialize(message)
    @message = message
    @length = @message.length + 2
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + ("-" * length) + "+"
  end

  def empty_line
    "|" + (" " * length) + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner