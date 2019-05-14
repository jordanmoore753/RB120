class Book
  attr_reader :title, :author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin 

I only used attr_reader because I don't want to open
up the instance variables to unnecessary manipulation.
There is no need for the program or user to write
or re-assign data to the instance variables so I'm not
going to give it the capability of doing so.

=end