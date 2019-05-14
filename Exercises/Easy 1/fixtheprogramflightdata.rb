class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin 

God only knows how much havoc could be
caused by leaving the accessor method for
database_handle. If it contains all information
regarding ALL flights, you certainly don't want
users to write AND read all of that data at will.
I mean, there wasn't even protection in this program!
Users have no need to read or write data
for this instance variable.

=end