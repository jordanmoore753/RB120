module Rims
  def can_tow?
    true
  end
end

class Vehicle
  attr_accessor :color, :model, :speed, :year
  
  @@number_of_vehicles = 0

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

  def spray_paint(n)
    self.color = n
    puts "That new coat of #{n} looks great."
  end

  def to_s
    puts "Your car is a #{year} #{model} and is #{color}."
  end

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "We've created #{@@number_of_vehicles} vehicles."
  end

  def calc_age
    puts "#{time}"
  end

  private

  def time
    now = Time.now
    now_year = now.year
    now_year - year
  end
end

class MyCar < Vehicle
  include Rims

  NUMBER_OF_DOORS = 2
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 6
end


tauros = MyCar.new(2009, 'Red', 'Sedan')

tauros.info
g = MyTruck.new(2019, 'Blue', 'Patriot')

tauros.spray_paint('Red')
tauros.calc_age

#

class Student
  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(var)
    puts "Well done!" if grade? > var.grade? 
  end

  protected

  attr_reader :grade

  def grade?
    @grade
  end

end

joe = Student.new('Joe', 65)
bob = Student.new('Bob', 62)
joe.better_grade_than?(bob)