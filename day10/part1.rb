#!/usr/bin/env ruby

def open_file(filename)
  File.readlines(filename)
end

def signal_sum(data, signals)
  all_x = Hash.new(1)
  queu = []
  x = 1
  i = 1
  data.each { |line| queu.insert(0, { value: line.split[1].to_i || 0, wait: line.split[0] == 'noop' ? 0 : 2 }) }
  while queu.count > 0
    all_x[i] = x
    queu.last[:wait] -= 1
    x += queu.pop[:value] if queu.last[:wait] <= 0
    i += 1
  end

  signals.map { |signal| all_x[signal] * signal if signal < all_x.keys.max }.sum
end

puts signal_sum(open_file('input.txt'), signals = [20, 60, 100, 140, 180, 220]) # right answer 15220
