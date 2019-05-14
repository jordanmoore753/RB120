class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin 

I do not like this method of adding books and authors.
They should be paired entry, since it would be easy for
the program to potentially misplace the author of a book
as the author of another book, and vice-versa. Also, someone
who doesn't understand how the program may falsely
assume that the program can pull an author's name by looking
at the input title. This one can't do that! So, we would
be missing the author for a book title.

=end