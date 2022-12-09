#!/usr/bin/env ruby

def char_values(characters)
  characters.map do |char|
    if ('A'..'Z').include? char
      char.ord - 38
    elsif ('a'..'z').include? char
      char.ord - 96
    end
  end
end

def priorities(data)
  data.map do |line|
    length = line.length
    compartment1 = line[0, length / 2]
    compartment2 = line[length / 2, length]

    compartment1.each_char { |char| break char if compartment2.include? char }
  end
end

def sum_priorities(data)
  priorities = priorities(data)
  values = char_values(priorities)
  values.sum
end

def open_file(filename)
  File.readlines(filename)
end

puts sum_priorities(open_file('input.txt')) # right answer 7863
