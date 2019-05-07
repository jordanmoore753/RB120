# class Team 
#   attr_accessor :name, :members

#   def initialize(n)
#     @name = n
#     @members = []
#   end

#   def <<(person)
#     members.push(person)
#   end

#   def +(other_team)
#     temp_team = Team.new('Temporary Titans')
#     temp_team.members = members + other_team.members
#     temp_team
#   end
# end

# class Person
#   attr_accessor :name, :age

#   def initialize(n, a)
#     @name = n
#     @age = a 
#   end

#   def >(other)
#     age > other.age
#   end
# end

# bob = Person.new('Bob', 49)
# kim = Person.new('Kim', 34)

# cowboys = Team.new('Cowboys')
# titans = Team.new('Titans')

# cowboys <<(kim)
# titans << bob

# ultimate = cowboys + titans 
# p ultimate

module Describable
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4

  def sides
    SIDES
  end
end

class Square < Quadrilateral; end

p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => "I am a Square and have 4 sides."