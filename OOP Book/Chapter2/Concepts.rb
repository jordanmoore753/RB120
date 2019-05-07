# class GoodDog
#   def initialize # This is not a module. This could be any name.
#     puts 'This object was initialized!'
#   end
# end

# boy = GoodDog.new

# If there is a method defined in the class,
# it will be invoked every time a new object
# is initialized with that class.

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h 
    @weight = w
  end

  def bark
    puts "#{name} barks!"
  end

  def info
    "#{name} weighs #{weight} pounds and is #{height} feet tall."
  end

  def change_info(n, h, w)
    self.name = n 
    self.height = h 
    self.weight = w 
  end
end

boy = GoodDog.new('Fido', 34, 35)

boy.weight = 36
p boy.info
boy.change_info('Popo', 654, 7654)
p boy.info

class Author

  def initialize

  end

  def name
    puts "Self inside class instance: #{self}."
    puts "Self.class inside class instance: #{self.class}"
  end
end

class Human < Author

end

yea = Author.new
yea.name

arr1 = [1]
arr2 = [1]
p arr1 == arr2