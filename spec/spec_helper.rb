$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))

require 'rubygems'
require 'parent_paths'

module SpecHelper

  def self.path_of_the_method_calling_this
    ParentPaths.send :caller_path
  end

  def self.path_of_this_method_being_called
    path_of_the_method_calling_this
  end

end