class Pet
  attr_reader :name

  def initialize(n)
    @name = n.to_s
  end

  def to_s
    "My name is #{name.upcase}"
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin 

This code works because `to_s` in initialize
is converting the input into a string. 

#name can be still accessed outside of the object,
so this variable can be re-assigned at will.

=end