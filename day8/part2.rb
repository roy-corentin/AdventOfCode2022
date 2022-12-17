#!/usr/bin/env ruby

def nb_visible_tree(data)
  visibles = []
  count = 0

  data.map { |line| line.map(&:to_i) }
  data.each_with_index do |line, j|
    visible_line = []
    line.each_with_index do |tree, i|
      visible_line << (visible_on_line?(line,tree, i) || visible_on_column?(data, tree, j, i) ? 1 : 0)
    end
    visibles << visible_line
  end
  visibles.each { |line| puts line.inspect }
  visibles.map { |line| line.sum }.sum
end

def visible_on_line?(line, height, i)
  size = line.size
  left = ( i>0 ? line[..i-1] : [] ).all? { |tree| tree < height  }
  right = (i < size-1 ? line[i+1..] : [] ).all? { |tree| tree < height  }

  left || right
end

def visible_on_column?(data, height, j, i)
  size = data.size
  left = []
  right = []
  data.each_with_index { |line, index| index < j ? left << line[i] : right << line[i] }
  left = left.all? { |tree| tree < height }
  right = right[1..].all? { |tree| tree < height }

  left || right
end

def open_file(filename)
  File.readlines(filename).map{ |line| line.chomp.split("").map(&:to_i) }
end

puts nb_visible_tree(open_file('input.txt')) # right answer 1818
