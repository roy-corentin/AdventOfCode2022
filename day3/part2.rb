#!/usr/bin/env ruby

def char_values(characters)
  weights = characters.map do |char|
    if ('A'..'Z').include? char
      char.ord - 38
    elsif ('a'..'z').include? char
      char.ord - 96
    end
  end
end

def priorities(data)
  data.map do |lines|
    lines[0].each_char { |char| break char if lines[1].include?(char) and lines[2].include?(char) }
  end
end

def sum_priorities(data)
  priorities = priorities(data)
  values = char_values(priorities)
  values.sum
end

def open_file(filename)
  data = []
  stack = []
  i = 1
  File.readlines(filename).each do |line|
    stack << line
    if i % 3 == 0
      data << stack
      stack = []
    end
    i += 1
  end
  data
end

puts sum_priorities(open_file('input.txt')) # right answer 2488
