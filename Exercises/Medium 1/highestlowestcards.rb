module CanSwim
  def swim
    'swim'
  end
end

module CanTrain
  def train
    'train'
  end
end

class Dog
  include CanSwim
  include CanTrain
end

p Dog.ancestors