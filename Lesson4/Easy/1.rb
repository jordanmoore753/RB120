# 1

p true.class
p 'hello'.class
p [1,2,3, 'hello'].class
p 142.class

# They are all objects.

# 2

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle
  include Speed
end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

ca = Car.new
ca.go_fast

# 3

=begin 

The `self.class` variable refers to the object and class that the method is invoked within.
In this case, `self` refers to `Car` when it is invoked from the variable `ca`, since
it is an instance of the object `Car`.

=end

# 4

class AngryCat
  def hiss
    puts 'Hissss!!!!'
  end
end

jaeda = AngryCat.new
jaeda.hiss

# 5

# The second class, Pizza, has an instance variable @name.
# I know this because the `name` has a `@` in front of it,
# which signifies an instance variable. The other class
# has a `name` local variable.

# 6

class Cube
  attr_accessor :volume

  def initialize(volume)
    @volume = volume
  end
end

# 7

# The default return value of `to_s` when invoked on an
# object is the name of the class and the object ID.
# You can check this by doing `puts jaeda`, which is the same
# as jaeda.to_s. Or, you can go to the Intro to OOP book
# like I did!

# 8

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_older
    self.age += 1
  end
end

milo = Cat.new('Red')
p milo
milo.make_older
p milo

# self refers to the object that invokes the method.
# In this case, the self is 'milo', and the variable
# `age` of milo will be incremented by 1.

# 9

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

mike = Cat.new('Red')
puts Cat.cats_count

# The self refers to the calling object, which is `Cat`, since that's
# the class that the class variable was initialized within. Also, self
# in the method definition signals that it is a class method, which means
# it can only be used by the class itself, not instances of it.

# 10

class Bag
  def initialize(color, mat)
    @color = color
    @mat = mat
  end
end

fred = Bag.new('Red', 'Vinyl')
p fred