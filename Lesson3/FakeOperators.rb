class Team 
  attr_accessor :name, :members

  def initialize(n)
    @name = n
    @members = []
  end

  def <<(person)
    members.push(person)
  end

  def +(other_team)
    temp_team = Team.new('Temporary Titans')
    temp_team.members = members + other_team.members
    temp_team
  end
end

class Person
  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age = a 
  end

  def >(other)
    age > other.age
  end
end

bob = Person.new('Bob', 49)
kim = Person.new('Kim', 34)

cowboys = Team.new('Cowboys')
titans = Team.new('Titans')

cowboys <<(kim)
titans << bob

ultimate = cowboys + titans 
p ultimate
