module Drool
  def drool
    puts "#{self.name} drooled!"
  end
end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def pet_jump
    @pets.each { |pet| puts "#{pet.name} jumped!"}
  end

  def vaccinated_check?
    @pets.each { |pet| puts pet.vacc == true }
  end 

  def drool
    @pets.each { |pet| pet.drool }
  end
end

class Bulldog
  include Drool
  attr_accessor :name, :vacc

  def initialize(name, vacc_record)
    @name = name
    @vacc = vacc_record
  end 
end

tommy = Person.new('Tommy')
punk = Bulldog.new('Punk', true)
tank = Bulldog.new('Tank', false)

tommy.pets << punk
tommy.pets << tank 

tommy.vaccinated_check?

tommy.pet_jump
tommy.drool

puts Bulldog.ancestors
