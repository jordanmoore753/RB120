class Customer
  OPTIONS = {'poop' => 0}
  attr_reader :order 

  def place_order
    
  end

  def test
    puts "#{self.class::OPTIONS}"
  end

  def self.test2
    puts "#{self::OPTIONS}"
  end
end

=begin
class Order
  attr_reader :burger, :side, :drink

  def initialize
    @burger = Burger.new
    @side = Side.new
    @drink = Drink.new   
  end

  def meal
    [@burger, @side, @drink]
  end

  def to_s
    meal.map(&:to_s).join(', ')
  end
end


class MealItem
  attr_reader :item_options

  def initialize
    @item_options = 'Burger, Fries, Drink'
  end

  def choose_option
    puts "Please choose a #{self.class} option:"
    puts item_options 
                      
    gets.chomp
  end

end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
  }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end
=end
me = Customer.new
me.place_order
puts me.order
me.test
me.test2