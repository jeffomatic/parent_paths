require 'pathname'

module ParentPaths

  # From the given starting path, scan upward through the file hierachy until
  # a particular criteria is met. The criteria is determined by a block that
  # receives the path of the next directory in the hierarchy.
  #
  # If a starting path is not provided, it is assumed to be the path of the
  # file that calls this method.
  def self.scan(start = nil, &criteria)
    start ||= caller_path
    start = Pathname.new(start)
    if criteria.call(start)
      return start
    else
      parent = start.parent
      if start == parent
        nil
      else
        scan parent, &criteria
      end
    end
  end

  # From the given starting path, scan upward through the file hierachy until
  # a particular filename is discovered.
  #
  # If a starting path is not provided, it is assumed to be the path of the
  # file that calls this method.
  def self.scan_for_owner(filename, start = nil)
    start ||= caller_path
    scan(start) { |pathname| File.exist?(pathname + filename) }
  end

  # Returns the path of the file that calls the method that calls caller_path.
  # For example if, foo.rb#foo calls caller_path, calling foo.rb#foo will return
  # the current file.
  def self.caller_path
    matches = caller(2).first.match(/(.*):\d+:in `/)
    Pathname.new(File.expand_path(matches[1]))
  end

end