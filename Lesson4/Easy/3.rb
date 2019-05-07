# 1 - 2

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    puts 'Hello'
  end

  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

hello = Hello.new

# hello.hi # => 'Hello'
# hello.bye # => NoMethodError since Hello and Goodbye don't share methods.
# hello.greet #'Wrong Argument Number' since we need an argument
# hello.greet('Goodbye') => This argument must overwrite the input parameter for greet.
# Hello.hi => Instance methods can only be used on instances of the class.

# 3

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

jaeda = AngryCat.new(3, 'Jaeda')
hoppy = AngryCat.new(4, 'Hoppy')

# 4

# class Cat
#   attr_reader :type

#   def initialize(type)
#     @type = type
#   end

#   def to_s
#     puts "I am a #{type} cat."
#   end
# end

# hen = Cat.new('Tabby')
# hen.to_s

# 5

=begin 
tv.manufacturer => Nomethoderror -- It is a class method, not an instance method
tv.model => No error, all good.

Television.manufacturer => all good.
Television.model => NOMETHODERROR - instance method, not a class method.

=end

# 6

class Cat
  attr_accessor :type, :age 

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_older
    @age += 1
  end
end

ja = Cat.new('Dirt')
ja.make_older

# 7

=begin 

1. The brightness and color values are never used despite
the references to them in the information class method.
2. The class method uses an unnecessary return. Implicit return
will return the last line of a method as the return value
automatically.

=end