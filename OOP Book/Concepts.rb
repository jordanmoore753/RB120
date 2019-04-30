

# class GoodDog

# end

# sparky = GoodDog.new

# Modules

module Speak
  def speak(str)
    puts str
  end
end

class GoodDog
  include Speak
end

class Human
  include Speak
end

sparky = GoodDog.new
sparky.speak('Yo!')
bobby = Human.new
bobby.speak('Ruff!')

puts GoodDog.ancestors