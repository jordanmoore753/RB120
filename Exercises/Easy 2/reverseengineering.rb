=begin 

input = string
output = string
rules = create a class, transform, that when passed
        a string as an argument, will transform
        that string to uppercase or lowercase when
        appropriate method invoked.

algorithm =
- create transform class
- initialize @word to input word
- define uppercase method
  - non destructive upcase on the @word
- define lowercase method 
  - non destructive downcase on the @word


=end

class Transform
  attr_reader :word

  def initialize(w)
    @word = w 
  end

  def uppercase
    word.upcase
  end

  def self.lowercase(w)
    w.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')