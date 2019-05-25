# Encapsulation

class Person
  def initialize(name)
    @name = name
  end
  
  def hello_from_other_obj(other)
    puts "#{other.name} sings: 'Hello from the other object!' to #{name}."
  end
  
  protected
  
  attr_reader :name
end

person1 = Person.new('Dave')
person2 = Person.new('Adele')
person1.hello_from_other_obj(person2)

# POLYMORPHISM

class Duck
  def quack
    puts "Quack!"
  end
end

class Person
  def quack
    puts "I imitate a duck QUACK!"
  end
end

def in_the_pond(duck)
  duck.quack
end

me = Person.new
doug = Duck.new
in_the_pond(me)

# Inheritance

module Flying
  def flying
    puts "#{self.name} is flying."
  end
end

class Mammal
  attr_reader :name
  
  def initialize(n)
    @name = n
  end
end

class FlyingSquirrel < Mammal
  include Flying
end

class Dog < Mammal
end

me = FlyingSquirrel.new('Jordan')
me.flying

# Modules

module Swimmable
  def swimming
    puts "#{self.name} is swimming."
  end
end

class Mammal
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Cat < Mammal; end

class Dog < Mammal
  include Swimmable
end

rufus = Cat.new('Rufus')
ted = Dog.new('Ted')
ted.swimming

# Method Lookup Path

class Organism
  attr_reader :desire_to_live

  def desire_to_live
    @desire_to_live = true
  end
end

class Mammal < Organism
  def breathe
    puts "I breathe with lungs."
  end
end

class Cat < Mammal
  def initialize(name, breed)
    @name = name
    @breed = breed
  end
end

rufus = Cat.new('Rufus', 'Shorthair')
rufus.breathe
puts rufus.desire_to_live
p Cat.ancestors

# self

class Chimp

  puts "outer scope is #{self}."

  def self.what_is_self
    puts self
  end

  def what_is_self
    puts self
  end
end

dude = Chimp.new
Chimp.what_is_self
dude.what_is_self

# to_s

class Dog
  def to_s
    "I am the object."
  end
end

me = Dog.new
puts me

# Single Inheritance

module Accessory

end

class Clock; end

class Watch < Clock
  include Accessory
end

# Collaborator Objects

class Apple 
  def initialize

  end

  def add_employee

  end
end

class Employee 

end

class Boss 

end

class PartTimeEmployee 

end

# Getter/Setter

class Dog
  attr_reader :name, :weight
  attr_writer :weight
  
  def initialize(name, weight)
    @name = name
    @weight = weight
  end
  
  def weight=(new_weight)
    @weight = new_weight 
  end
  
  def change_weight(new_weight)
    self.weight = new_weight
  end
end

rufus = Dog.new('Rufus', 32)
puts rufus.weight
rufus.weight = 35
puts rufus.weight

# Namespacing

module Mammal
  class Chimp
    def speak
      puts "Grunt."
    end
  end

  class Dog
    def speak
      puts "Bark."
    end
  end
end

me = Mammal::Chimp.new
me.speak

# Method Overriding

class Vehicle
  attr_reader :brand, :year
  
  def initialize(brand, year)
    @brand = brand
    @year = year
  end 
end

class SUV < Vehicle
  attr_reader :seats
  
  def initialize(brand, year, seats)
    super(brand, year)
    @seats = seats
  end
end

big = SUV.new('Cobalt', 2009, 18)
p big
