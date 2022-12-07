#!/usr/bin/env ruby

def first_marker(_size, data)
  puts data
end

def open_file(filename)
  File.read(filename)
end

first_marker(4, open_file('input6.txt'))
