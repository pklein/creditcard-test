#!/usr/bin/env ruby


def luhn_check num
  num.reverse.chars.map(&:to_i).each_with_index.map {|x,i| i%2==0 ? x : x*2%10 + x*2/10}.inject(:+) % 10 == 0
end

results = STDIN.read.split("\n").map {|line|
  card_num = line.gsub(/\s+/, '')
  card = { :type => 'Unknown', :card_num => card_num, :valid => false }
  if card_num =~ /^3[47]\d{13}$/
    card = {:type => 'AMEX', :card_num => card_num, :valid => luhn_check(card_num) }
  elsif card_num =~ /^6011\d{12}$/
    card = {:type => 'Discover', :card_num => card_num, :valid => luhn_check(card_num) }
  elsif card_num =~ /^5[1-5]\d{14}$/
    card = {:type => 'MasterCard', :card_num => card_num, :valid => luhn_check(card_num) }
  elsif card_num =~ /^4(?:\d{12}|\d{15})$/
    card = {:type => 'VISA', :card_num => card_num, :valid => luhn_check(card_num) }
  end
  card
}.map {|c| c[:type] + ': ' + c[:card_num] + (c[:valid] ? ' (valid)' : ' (invalid)')}.join("\n")

puts results

