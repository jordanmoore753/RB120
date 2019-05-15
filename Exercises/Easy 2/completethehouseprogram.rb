class House
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def bigger(house2)
    return "Home 1 is cheaper" if price < house2.price
    return "Home 2 is more expensive" if price > house2.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts home1.bigger(home2)
puts home2.bigger(home1)