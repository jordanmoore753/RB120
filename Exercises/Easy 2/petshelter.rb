class Pet
  attr_reader :type, :name 

  def initialize(type, n)
    @type = type
    @name = n 
  end
end

class Owner
  attr_reader :name, :pets, :number_of_pets

  def initialize(n)
    @name = n
    @pets = []
    @number_of_pets = 0
  end

  def adopt_pet(ani)
    @number_of_pets += 1
    pets << ani
  end

  def display_pets
    puts "#{name} has adopted the following pets:"
    pets.each { |pet| puts "a #{pet.type} named #{pet.name}" }
  end
end

class Shelter
  attr_reader :owners

  def initialize
    @owners = []
  end

  def adopt(human, animal)
    owners << human unless owners.include?(human)
    human.adopt_pet(animal)
  end

  def print_adoptions
    owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet.type} named #{pet.name}"
      end
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."