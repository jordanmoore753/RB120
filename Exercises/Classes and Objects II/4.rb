class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hi, I am cat."
  end

  def personal_greeting
    puts "Hi, I am #{name}."
  end
end

kitty = Cat.new('Sophie')
Cat.generic_greeting
kitty.personal_greeting
