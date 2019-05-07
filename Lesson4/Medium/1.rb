# 1

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

pap = BankAccount.new(400)
pap.positive_balance?

=begin 

Ben is correct because the attr_reader creates the getter method
for @balance which looks like: def balance; balance; end. So,
@balance is retrieved by the use of the `balance` getter method.

=end

# 2

class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(prod, numb)
    @quantity = numb
    @product_name = prod 
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

der = InvoiceEntry.new('Dirt', 45)
der.update_quantity(23)
p der

=begin 

Alyssa is correct because on line 42 we are initializing a
new local variable named quantity and assigning it the value
of the parameter updated_count. The attr_reader only gives
reading permission, not writing permission, so we cannot 
access and change @quantity without the @.

=end

# 3

=begin

The only problem I see with changing the attr_reader to accessor and
giving writing rights to a setter method for quantity, is that
now the quantity can be updated without the use of the updatequantity
method, so this may lead to errors down the road as people
can freely edit a public instance variable.

=end

# 4

class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi 
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

i = Hello.new
x = Goodbye.new
i.hi
x.bye

# 5

class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling, glazing)
    @filling_type = filling 
    @glazing = glazing
  end

  def to_s
    first, second = nil, nil
    filling_type != nil ? first = filling_type : first = 'Plain'
    glazing != nil ? second = glazing : second = nil

    if (first != 'Plain' && second != nil) || (first == 'Plain' && second != nil)
      first + ' with ' + second
    else
      first
    end
  end
end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1 
# puts donut2
# puts donut3
# puts donut4
# puts donut5

# 6

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = 'template 14231'
#   end

#   def show_template
#     template
#   end
# end

class Computer 
  attr_accessor :template

  def create_template
    self.template = 'template 14231'
  end

  def show_template
    template
  end
end

ye = Computer.new
ye.create_template
p ye.show_template

=begin

The difference in how they work is their use of `self` and 
the explicit use of the instance variable @. The accessor getter
and setter makes it so that you don't need self on the template
variable unless you're setting it. If you're just getting it, you're
good to just use `template`. The first example is a more concise way
to write and reference the variable names.

=end

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_info
    "I want to turn on the light with brightness level: #{brightness}, and set its color to #{color}."
  end
end

ii = Light.new('Super Bright', 'Red')
puts ii.light_info