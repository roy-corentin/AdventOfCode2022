#!/usr/bin/env ruby
# frozen_string_literal: true

def first_marker(data, size)
  (data.length - size).times do |i|
    elems = data[i...i + size]
    break i + size if elems.split('').map { |e| elems.count(e) == 1 }.all?(true)
  end
end

def open_file(filename)
  File.read(filename)
end

puts(first_marker(open_file('input.txt'), 4)) # right answer part 1: 1953
puts(first_marker(open_file('input.txt'), 14)) # right answer part 2: 2301
