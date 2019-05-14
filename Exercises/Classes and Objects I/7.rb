class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.name = 'Tiger'
kitty.greeting