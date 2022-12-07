#!/usr/bin/env ruby

def open_file(filename)
  File.readlines(filename)
end

def parser(lines, data = {}, location = [], sum = 0)
  lines.reject { |e| e.start_with?('$ ls') }.each do |line|
    elements = line.split.delete_if { |e| e == '$' }
    case elements[0]
    when 'cd'
      (elements[1] != '..' ? location << path(elements[1]) : location.delete_at(-1))
    when 'dir'
      data[location.join + path(elements[1])] = 0
    else
      data[location.join + path(elements[1])] = elements[0].to_i
      sum += elements[0].to_i
    end
  end
  data.filter { |_key, value| value == 0 }.each_key do |location|
    data.each do |location2, size2|
      data[location] += size2.to_i if location2.start_with?(location)
    end
  end
  data['/'] = sum
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

def file_to_delete(data, directories = [], max_space = 70_000_000, target = 30_000_000)
  data.each_key do |location|
    directories << location if data.keys.any? { |loc| loc != location && loc.start_with?(location) }
  end
  used_space = data['/']
  free_space = max_space - used_space
  directories = directories.filter { |directory| data[directory] + free_space >= target }
  values = directories.map { |dir| data[dir] }
  values.min
end

print(file_to_delete(parser(open_file('input.txt')))) # rigth answer 2832508
