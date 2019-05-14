class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_s
    "My #{self.class} #{@name} is #{@age} years old and has #{color} fur."
  end
end

class Cat < Pet
  attr_reader :color

  def initialize(name, age, color)
    super(name, age)
    @color = color
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch