=begin 

input = string
output = array
rules = define a class named FixedArray
        that upon instantiating an instance of its class
        takes an argument number and makes that
        the size of the array

algorithm =
- define class Fixedarray 
 - initialize with parameter num
 - @length instance variable is assigned to num * nil into to_a
- define instance method [num]
  return the length[num]
- define instancne method [num]=(input)
  - length[num] = input
- define to_a instance method
  - returns the array of length


=end

class FixedArray
  attr_reader :arr

  def initialize(num)
    @arr = Array.new(num)
  end

  def [](index)
    arr.fetch(index)
  end

  def []=(index, input)
    self[index]
    @arr[index] = input
  end

  def to_a
    arr
  end
  
  def to_s
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end




