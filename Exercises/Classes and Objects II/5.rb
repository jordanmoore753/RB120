class Cat
  @@number_of_cats = 0

  def initialize
    @@number_of_cats += 1
  end

  def self.total
    puts "#{@@number_of_cats}"
  end
end

kitty = Cat.new
dirty = Cat.new
Cat.total
