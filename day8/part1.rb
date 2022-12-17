#!/usr/bin/env ruby

def nb_visible_tree(data)
  visibles = []
  count = 0

  data.map { |line| line.map(&:to_i) }
  data.each_with_index do |line, j|
    visible_line = []
    line.each_with_index do |tree, i|
      visible_line << nb_visible_on_line(line,tree, i) * nb_visible_on_column(data, tree, j, i)
    end
    visibles << visible_line
  end
  visibles.each { |line| puts line.inspect }
  visibles.map { |line| line.max }.max
end

def nb_visible_on_line(line, height, i)
  size = line.size
  count_left = 0
  count_right = 0
  left = ( i>0 ? line[..i-1] : [] ).reverse.each do |tree|
    count_left += 1
    break if tree >= height
  end
  right = (i < size-1 ? line[i+1..] : [] ).each do |tree|
    count_right += 1
    break if tree >= height
  end
  if height == 5
    puts count_left
    puts count_right
  end

  count_left * count_right
end

def nb_visible_on_column(data, height, j, i)
  count_up = 0
  count_down = 0
  up = []
  down = []
  data.each_with_index { |line, index| index < j ? up << line[i] : down << line[i] }
  up.reverse.each do |tree|
    count_up += 1
    break if tree >= height
  end
  down[1..].each do |tree|
    count_down += 1
    break if tree >= height
  end

  count_up * count_down
end

def open_file(filename)
  File.readlines(filename).map{ |line| line.chomp.split("").map(&:to_i) }
end

puts nb_visible_tree(open_file('input.txt')) # right answer 368368
