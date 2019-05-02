# 1, 2, 3

class Pet
  def run
    'running'
  end

  def jump
    'jumping'
  end
end

class Dog < Pet
  def fetch
    'fetching'
  end

  def swim
    'swimming!'
  end

  def speak
    'bark'
  end
end

class Cat < Pet
  def speak
    'meow'
  end

  def swim
    'cannot swim'
  end

  def fetch
    'cannot fetch'
  end
end

class Bulldog < Dog
  def swim
    'cannot swim!'
  end
end

teddy = Dog.new
mick = Bulldog.new
jaeda = Cat.new
puts jaeda.fetch
puts teddy.swim 
puts mick.swim
puts jaeda.run
puts Bulldog.ancestors

# 4

# The method look path is the order in which Ruby will
# check the class hierarchy to determine which method to
# invoke. It goes subclass first, to the highest superclass.