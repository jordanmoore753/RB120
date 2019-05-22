class Minilang
  attr_reader :stack, :commands
  attr_accessor :register

  def initialize(str)
    @commands = str.split(' ')
    @register = 0
    @stack = []
  end

  def eval
    command_val = nil

    commands.each do |command|
      command_val = which_command(command)
      if command_val == 'Empty Stack!' 
        puts 'Empty Stack!'
        break
      elsif command_val == 'Invalid token'
        puts "Invalid token: #{command}"
        break
      end
    end
  end

  def which_command(str)
    if str.downcase != str
      call_command(str.downcase)
    else
      add_register(str.to_i)
    end
  end

  def call_command(input)
    case input
    when 'push' then push 
    when 'mult' then mult
    when 'print' then print 
    when 'add' then add 
    when 'sub' then sub 
    when 'pop' then pop
    when 'div' then div
    when 'mod' then mod
    else
      "Invalid token"
    end
  end

  private

  def add_register(num)
    self.register = num
  end

  def push
    stack << register
  end

  def mult
    mult_num = stack.pop
    self.register *= mult_num
  end

  def print
    puts register
  end

  def add
    mult_num = stack.pop
    self.register += mult_num  
  end

  def sub
    mult_num = stack.pop
    self.register -= mult_num
  end

  def div
    mult_num = stack.pop
    self.register = self.register / mult_num
  end

  def mod
    mult_num = stack.pop
    self.register = self.register % mult_num
  end

  def pop
    return 'Empty Stack!' if stack.empty?
    mult_num = stack.pop
    self.register = mult_num
  end
end


Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)