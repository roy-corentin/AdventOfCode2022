#!/usr/bin/env ruby

def open_file(filename)
  File.readlines(filename)
end

def move(data, stacks)
  data.each do |line|
    words = line.split
    words[1].to_i.times do
      stacks[words[5]].push(stacks[words[3]].pop)
    end
  end
  stacks.map { |_key, value| value.last }.join
end

stacks = { '1' => %w[G F V H P S], '2' => %w[G J F B V D Z M], '3' => %w[G M L J N], '4' => %w[N G Z V D W P],
           '5' => %w[V R C B], '6' => %w[V R S M P W L Z], '7' => %w[T H P], '8' => %w[Q R S N C H Z V],
           '9' => %w[F L G P V P Q J] }

puts move(open_file('input.txt'), stacks) # right answer FCVRLMVQP
