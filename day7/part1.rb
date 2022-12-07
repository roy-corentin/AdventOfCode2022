#!/usr/bin/env ruby

def open_file(filename)
  File.readlines(filename)
end

def parser(lines, data = {}, location = [])
  lines.reject { |e| e.start_with?('$ ls') }.each do |line|
    elements = line.split.delete_if { |e| e == '$' }
    case elements[0]
    when 'cd'
      (elements[1] != '..' ? location << path(elements[1]) : location.delete_at(-1))
    when 'dir'
      data[location.join + path(elements[1])] = 0
    else
      data[location.join + path(elements[1])] = elements[0].to_i
    end
  end
  data.filter { |_key, value| value == 0 }.each_key do |location|
    data.each do |location2, size2|
      data[location] += size2.to_i if location2.start_with?(location)
    end
  end
  data
end

def path(element)
  element + (element.end_with?('/') ? '' : '/')
end

def sum_dir_at_most(data, max, directories = [])
  data.each_key do |location|
    directories << location if data.keys.any? { |loc| loc != location && loc.start_with?(location) }
  end
  directories = directories.filter { |directory| data[directory] <= max }

  directories.inject(0) { |sum, dir| sum += data[dir] }
end

print(sum_dir_at_most(parser(open_file('input.txt')), 100_000)) # rigth answer 1182909
