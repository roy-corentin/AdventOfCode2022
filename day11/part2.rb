#!/usr/bin/env ruby

def multiply_two_most_active_monkey(data, nb_round)
  two_most_active_monkey(data, nb_round).reduce(&:*)
end

def two_most_active_monkey(data, nb_round)
  monkeys = parse_data(data)

  # print_monkeys(monkeys)
  nb_round.times { monkeys = next_round(monkeys.dup) }
  # print_monkeys(monkeys)
  inspections = monkeys.map { |_id, monkey| monkey['inspection'] }.sort.reverse
  inspections.first(2)
end

def parse_data(data)
  parsed_data = {}
  divisors = []

  data.each_with_index do |line, index|
    next unless line.start_with?('Monkey')

    monkey = parse_monkey(data, index)
    parsed_data[monkey['id']] = monkey
    divisors << monkey['by']
  end
  lcm = divisors.reduce(&:*)
  parsed_data.map { |_id, monkey| monkey['lcm'] = lcm }
  parsed_data
end

def parse_monkey(data, index)
  id = data[index].split(' ').last.split(':').first
  items = data[index + 1].split(':').last.split(' ').map(&:to_i)
  operator = data[index + 2].split('=').last.split(' ')[1]
  operant = data[index + 2].split('=').last.split(' ')[2]
  operation = proc { |object| object.send(operator, (operant == 'old' ? object : operant.to_i)) }
  by = data[index + 3].split('by').last.to_i
  test = proc { |elem| (elem % by).zero? }
  if_true = data[index + 4].split('monkey')[1].strip
  if_false = data[index + 5].split('monkey')[1].strip

  { 'id' => id, 'items' => items, 'operation' => operation, 'test' => test, 'true' => if_true,
    'false' => if_false, 'inspection' => 0, 'by' => by }
end

def next_round(monkeys)
  next_turn = {}
  monkeys.each do |id, monkey|
    next_turn[id] = monkey.dup
    next_turn[id]['items'] = []
  end

  monkeys.each do |id, monkey|
    next if monkey['items'].size.zero?

    next_turn[id]['inspection'] += monkey['items'].size
    new_items = monkey['items'].map(&monkey['operation']).map { |object| object % monkey['lcm'] }
    tests = new_items.map(&monkey['test'])
    tests.each_with_index do |boolean, index|
      id < monkey[boolean.to_s] ? monkeys[monkey[boolean.to_s]]['items'] << new_items[index] : next_turn[monkey[boolean.to_s]]['items'] << new_items[index]
    end
  end
  next_turn
end

def print_monkeys(monkeys)
  monkeys.each do |id, monkey|
    puts "Monkey #{id}: #{monkey['items'].inspect}, #{monkey['inspection']}"
  end
  puts
end

def open_file(filename)
  File.readlines(filename)
end

puts multiply_two_most_active_monkey(open_file('input.txt'), 10_000) # right answer is 13937702909
