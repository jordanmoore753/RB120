class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(n)
    self.name = n # or @name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.name
kitty.rename('Chloe')
p kitty.name
p kitty.identify