# class Animal
#   attr_accessor :name

#   def speak
#     'Hello!'
#   end

#   def initialize(name)
#     @name = name
#   end
# end

# class GoodDog < Animal
#   DOG_YEARS = 7

#   attr_accessor :age

#   def initialize(n, a)
#     super(n)
#     self.age = a * DOG_YEARS
#   end

#   def speak
#     super + " from GoodDog class"
#   end

#   def self
#     p "#{name}, #{age}"
#   end
# end

# lola = GoodDog.new('Lola', 3)
# jack = GoodDog.new('Jack', 2)
# lola.self
# lola.name = 'Dirt'
# lola.self

module Mammal

  def self.some_crazy_method(n)
    n ** 2
  end

  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end


  class Cat
    def speak(sound)
      p "#{sound}"
    end

    def public
      'Testing!' + "#{human_years}"
    end

    protected

    def human_years
      4 * 12
    end
  end
end

lola = Mammal::Dog.new
jaeda = Mammal::Cat.new

p jaeda.public