class Vehicle
  attr_reader :year

  def initialize(y)
    @year = y
  end
end

class Truck < Vehicle
  attr_reader :length

  def initialize(y, length)
    super(y)
    @length = length
  end
end

class Car < Vehicle; end

truck1 = Truck.new(1994, 'short')
puts truck1.year
puts truck1.length

car1 = Car.new(2006)
puts car1.year