=begin 

input = integer
output = integer or nil
rules = 

algorithm=
-define class cicularqueue
  - initialize array variable set to newarray.new(input)
- dequeue method
  - return nil if array all are nil
  - otherwise remove the minimum number of the array
- enqueue method
  - if array count of elements that are nil is 0, replace 
    the lowest number with highest element + 1
  - append the maximum element of array + 1 to array

=end

class CircularQueue
  attr_reader :arr

  def initialize(max_size)
    @arr = Array.new(max_size)

  end

  def dequeue
    return nil if arr.all? { |ele| ele.nil? }
    only_nums = arr.select { |ele| ele.is_a? Integer }
    lowest_num = only_nums.min 
    lowest_num_idx = arr.index(lowest_num)
    return_num = arr[lowest_num_idx]
    arr[lowest_num_idx] = nil 
    return_num
  end

  def enqueue(input)
    only_nums = arr.select { |ele| ele.is_a? Integer }
  
    if arr.any? { |ele| ele.nil? }
      nil_index = arr.index(nil)
      arr[nil_index] = input
    else
      lowest_num = only_nums.min       
      lowest_num_idx = arr.index(lowest_num)
      arr[lowest_num_idx] = input
    end
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil