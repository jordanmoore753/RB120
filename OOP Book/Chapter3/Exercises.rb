class MyCar
  attr_accessor :color, :model, :speed
  attr_reader :year

  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} is the gas mileage."
  end

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m
    @speed = 0
  end

  def info
    puts "#{year}, #{color}, #{model}, #{speed}"
  end

  def speed_up
    self.speed += 5
  end

  def brake
    self.speed -= 5
  end

  def off
    self.speed = 0
  end

  def spray_paint=(n)
    self.color = n
    puts "That new coat of #{n} looks great."
  end

  def to_s
    puts "Your car is a #{year} #{model} and is #{color}."
  end
end

MyCar.gas_mileage(90, 45)
tauros = MyCar.new(2009, 'Red', 'Sedan')
puts tauros

# 

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

# We got the error because :name only had reading privileges.
# Changed it to #accessor and it works just fine!