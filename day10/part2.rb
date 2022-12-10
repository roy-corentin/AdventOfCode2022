#!/usr/bin/env ruby

def open_file(filename)
  File.readlines(filename)
end

def signal_sum(data, _signals)
  queu = []
  sprites = ''
  x = 1
  i = 1
  data.each { |line| queu.insert(0, { value: line.split[1].to_i || 0, wait: line.split[0] == 'noop' ? 0 : 2 }) }
  while queu.count > 0
    queu.last[:wait] -= 1
    x += queu.pop[:value] if queu.last[:wait] <= 0
    sprites << (((i % 40) >= x - 1 and (i % 40) <= x + 1) ? '#' : '.')
    i += 1
  end

  [
    [sprites[..40]],
    [sprites[40..80]],
    [sprites[80..120]],
    [sprites[120..160]],
    [sprites[160..200]],
    [sprites[200..240]],
  ]
end

puts signal_sum(open_file('input.txt'), signals = [20, 60, 100, 140, 180, 220]) # right answer RFZEKBA
