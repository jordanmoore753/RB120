class MyCar
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m
    @speed = 0
  end

  def info
    puts "#{year}, #{color}, #{model}, #{speed}"
  end

  def speed_up
    self.speed += 5
  end

  def brake
    self.speed -= 5
  end

  def off
    self.speed = 0
  end

  def spray_paint=(n)
    self.color = n
    puts "That new coat of #{n} looks great."
  end

end

tauros = MyCar.new(2009, 'Red', 'Sedan')

