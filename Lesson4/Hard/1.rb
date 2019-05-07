# 1

class SecretFile
  attr_reader :usr, :access_amount

  def initialize(secret_data, usr)
    @data = secret_data
    @usr = usr
    @log = []
    @access_amount = 1
  end

  def data
    @log << "Access ##{access_amount}: #{SecurityLogger.new.create_log_entry}"
    @access_amount += 1
    puts @data
  end

  def display_log
    puts "#{usr} accessed '#{@data}'' at the following time(s): #{@log}."
  end
end

class SecurityLogger
  require 'date'

  def create_log_entry
    DateTime.now
  end
end

fred = SecretFile.new('Favorite Shows', 'Fred')
fred.data
fred.display_log
