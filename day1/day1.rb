#!/usr/bin/env ruby

def find_max_calorie(filename)
  input = File.read(filename)
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

  elves.max
end

puts(find_max_calorie('input1.txt')) # right answer is 68292 ✔
