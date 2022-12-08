#!/usr/bin/env ruby

def pair_contain_pair?(pair1, pair2)
  pair1.all? { |nb| pair2.include? nb } or pair2.all? { |nb| pair1.include? nb }
end

def nb_pair_containing_other(data)
  data.map do |line|
    range1, range2 = line.split(',')
    nb1, nb2 = range1.split('-')
    nb3, nb4 = range2.split('-')
    pair_contain_pair?((nb1.to_i)..(nb2.to_i), ((nb3.to_i)..(nb4.to_i)))
  end.count(true)
end

def open_file(filename)
  File.readlines(filename)
end

puts nb_pair_containing_other(open_file('input.txt')) # right answmer 562
