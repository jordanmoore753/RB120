# 1

class Person
  attr_accessor :name

  def initialize(n)
    @name = n
  end
end

# 2 - 3

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    split_name(full_name)
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def name=(n)
    split_name(n)
  end

  def split_name(str)
    full = str.split
    @first_name = full.first 
    full.size > 1 ? @last_name = full.last : @last_name = ''
  end

  def to_s
    name
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name

bob.name = "John Adams"
puts bob.first_name            # => 'John'
puts bob.last_name
bob.name

# 4          

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# 5

puts "The person's name is: #{bob}."