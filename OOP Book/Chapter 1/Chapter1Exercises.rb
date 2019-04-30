

class BigBoy

end

timmy = BigBoy.new

=begin 

Creating an object is as simple as defining the class 
and instantiating it with the #new method.

=end

# Modules

module Yell
  def speak(str)
    puts str.upcase
  end
end


class BigBoy
  include Yell
end

timmy = BigBoy.new

timmy.speak('Hi There Little Fellow')

=begin 

A module is a collection of behaviors that are usable
in other classes via mixins (include).

A module's purpose is to give more behaviors to 
classes and also eliminate the possibility of unwanted
data manipulation.

Above is the example.

=end