module App
  module CLI
    require "getopt/long"
    # Your code goes here...
  end
end

module Kernel
  def class_defined?(classname)
    eval("defined? #{classname} == \"constant\" && classname.is_a(Class)")
  end
end

class App::CLI::Dispatcher

  def self.find
    subcmd = ARGV.shift
    subcmd = self.to_s+"::"+subcmd.capitalize
    eval(subcmd) if class_defined?(subcmd)
  end

  def self.dispatch(*args)
    handler = self.find
    handler = handler.cascading if handler.cascadable
    options = handler.options
    handler.run( Getopt::Long.getopts(*options), args )
  end

end

class App::CLI::Command
  @@subcommands = []
  @@options = []

  def self.subcommands
    self.class_variable_defined?(:@@subcommands) ? @@subcommands : []
  end

  def self.options
    self.class_variable_defined?(:@@options) ? @@options : []
  end

  def self.cascading
    if subcmd = self.cascadable
      ARGV.shift
      eval(subcmd)
    end
  end

  def self.cascadable
    self.subcommands.each do |subcmd|
      return  ARGV[0].capitalize == subcmd && class_defined?(self.to_s+"::"+subcmd) ? self.to_s+"::"+subcmd : nil
    end
  end
end
