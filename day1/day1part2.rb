#!/usr/bin/env ruby

def calories_by_elves(input)
  elves = []
  elve = 0

  input.split("\n") do |line|
    if line.empty?
      elves << elve
      elve = 0
    else
      elve += line.to_i
    end
  end
  elves
end

def calories_from_file(filename)
  input(filename)
end

def input(filename)
  File.read(filename)
end

def find_3_max_calorie(filename)
  calories = calories_by_elves(input(filename))
  calories = calories.sort { |a, b| b <=> a }
  calories.first(3)
end

puts(find_3_max_calorie('input1.txt').sum)
