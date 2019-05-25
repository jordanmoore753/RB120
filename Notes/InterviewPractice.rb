class InterviewTopics
  attr_reader :option

  def initialize
    @option = ['inheritance', 'module', 'encapsulation',
               'polymorphism', 'getter/setter', 'OO design',
               'OOP purpose', 'single inheritance', 'method lookup path',
               'collaborator objects: when to use?', 'self', 'to_s',
               'namespacing' ]
  end

  def random
    puts "Teach me about: #{option.sample.capitalize}."
  end
end

option = InterviewTopics.new
option.random



