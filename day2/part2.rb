#!/usr/bin/env ruby

def strategy_score(data, lost = 0, draw = 3, win = 6)
  values = { 'X' => 1, 'Y' => 2, 'Z' => 3 }
  wins = { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
  draws = { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' }
  losts = { 'A' => 'Z', 'B' => 'X', 'C' => 'Y' }

  score = 0
  data.each_line do |line|
    case line[2]
    when 'Z'
      score += win
      score += values[wins[line[0]]]
    when 'Y'
      score += draw
      score += values[draws[line[0]]]
    when 'X'
      score += lost
      score += values[losts[line[0]]]
    end
  end
  score
end

def open_file(filename)
  File.read(filename)
end

puts strategy_score(open_file('input.txt')) # right answer 12725
