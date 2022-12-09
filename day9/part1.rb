#!/usr/bin/env ruby
# frozen_string_literal: true

def new_tail(x, y, zx, zy)
  xdiff = (x - zx)
  ydiff = (y - zy)

  if xdiff.abs > 1
    x > zx ? [zx + 1, zy] : [zx - 1, zy]
  elsif ydiff.abs > 1
    y > zy ? [zx, zy + 1] : [zx, zy - 1]
  else
    [x, y]
  end
end

def move(data, head = [0, 0], tail = [0, 0], visited_places = [])
  directions = { 'R' => [1, 0], 'L' => [-1, 0], 'U' => [0, 1], 'D' => [0, -1] }
  data.each do |line|
    direction, size = line.split
    size.to_i.times do
      head[0] += directions[direction][0]
      head[1] += directions[direction][1]
      tail = new_tail(tail[0], tail[1], head[0], head[1])
      visited_places << tail
    end
  end
  visited_places.uniq.size
end

def open_file(filename)
  File.readlines(filename)
end

puts move(open_file('input.txt')) # right answer 6030
