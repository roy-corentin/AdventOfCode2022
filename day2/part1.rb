#!/usr/bin/env ruby

def strategy_score(data, lost = 0, draw = 3, win = 6)
  values = { 'X' => 1, 'Y' => 2, 'Z' => 3 }
  ennemy = { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
  equivalent = { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' }

  score = 0
  data.each_line do |line|
    score += if ennemy[line[0]] == line[2]
               win
             elsif equivalent[line[0]] == line[2]
               draw
             else
               lost
             end
    score += values[line[2]]
  end
  score
end

def open_file(filename)
  File.read(filename)
end

puts strategy_score(open_file('input.txt'))
