class Oracle
  def predict_the_future
    'You will ' + choices.sample + '.'
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

oracle = Oracle.new
puts oracle.predict_the_future
trip = RoadTrip.new
puts trip.predict_the_future

# The result is blank, but if you invoke puts on line 12,
# you get "You will (random thing from choices method)."

# The result is the 'You will ...' with a choice from
# RoadTrip#choices. This is because the immediate class is
# searched first before the parent class when looking up
# methods.

# 3

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

ned = Orange.new
Orange.ancestors
HotSauce.ancestors

# They have the same lookup chain besides the first element
# in the chain which is the name of their own class.
# Everything else is the same.

# 4

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax."
  end
end

bum = BeesWax.new('Berry')

# 5

# excited_dog = 'local variable because no @'
# @excited_dog = 'instance variable because 1 @'
# @@excited_dog = 'class variable because 2 @'

# 6

=begin 

self.manufacturer is a class method and I know this because
it has `self` in the method definition before the name. This 
`self` is referring to the calling object, which in this case
is the class `Television`. You can test it by invoking the 
method `manufacturer` on `Television` not an instance of it.

=end

# 7

=begin 
The @@cats_count class variable is counting the amount of instances
instantiated from the class Cat. It works by everytime a new
object is instantiated from Cat, it increments cats_count by 1
when the object is initialized.

I can test my theory by invoking cats_count on Cat and by also
initializing a new object from Cat and checking cats_count again
after the new object is instantiated.

=end

# 8 - 9

class Game
  def play
    'Start the game!'
  end
end

class Bingo < Game 
  def play
    'Eat it!'
  end

  def rules
    'No'
  end
end

yeah = Bingo.new
puts yeah.play

# Defining a method in the sub-class with the same name
# as one in the parent class makes it so that the sub-class
# method is invoked since the method lookup chain begins
# within the calling object.

# 10

=begin 

1. Better organization of variables, methods, etc.
2. Implements DRY better than just a procedural approach.
3. Makes more intuitive sense for large-scale planning.
4. Naming can be extremely specific and mimic the planning process.
5. Frees up space and time by allocating specific functions and sharing them through inheritance.
6. Helps avoid large-scale compounding errors by private and protected methods that keep data safe.
7. More easily handled complexity. 
8. Make use of pre-written code.

=end

