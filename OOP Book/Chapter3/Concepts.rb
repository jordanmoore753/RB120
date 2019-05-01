class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  @@number_of_dogs = 0

  def initialize(n, a)
    self.name = n 
    self.age = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def self.number_of_dogs
    @@number_of_dogs
  end

  def what_is_self
    self
  end

end

lola = GoodDog.new('Lola', 3)
jack = GoodDog.new('Jack', 2)
puts lola.age
p lola.what_is_self
