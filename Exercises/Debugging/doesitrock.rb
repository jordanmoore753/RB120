class Person
  attr_reader :name, :shoes, :foot_size
  
  def initialize(name, foot_size)
    @name = name
    @foot_size = foot_size
    @shoes = []
  end
  
  def buy_shoes(brand)
    @shoes << Shoes.new(brand, foot_size)
  end
end

class Shoes
  attr_reader :size, :brand
  
  def initialize(brand, size)
    @brand = brand
    @size = size
  end
end

me = Person.new('Jordan', 9.5)
me.buy_shoes('Adidas')
p me