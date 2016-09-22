require 'date'

MAX_RATING = 10
FIELDS = %i( Link Title Year Country PremierDate Genre Duration Rating Director Stars)
DEFAULT_FILE = 'movies.txt'

def rating(movie)
  movie[:Rating].split('.').last.to_i
end

# 4-5
file_name = ARGV[0] || DEFAULT_FILE
abort("File with name '#{file_name}' is not exists.") unless File.exist?(file_name)

# 1
@movies = File.readlines(file_name).map { |line| FIELDS.zip(line.strip.split('|')).to_h }

# 2
search_result = @movies.select { |movie| movie[:Title][/Time/i] }
search_result.map { |movie| "#{movie[:Title]}, #{movie[:Rating]}" }

# 3
search_result.map { |movie| ['*' * rating(movie), movie[:Title]].join(' ' * (MAX_RATING - rating(movie))) }

## Task3 #2

puts @movies.sort_by { |movie| movie[:Duration].to_i }.last(5)

puts @movies.each{ |movie|
  y, m, d = movie[:PremierDate].split('-')

  y ||= '0000'
  m ||= '01'
  d ||= '01'

  movie[:PremierDate] = Date.parse([y, m, d].join('-'))
}

puts @movies.select { |movie| movie[:Genre][/comedy/i] }.sort_by { |movie| movie[:PremierDate] }.first(5)

directors = @movies.map { |movie| movie[:Director] }.uniq.map do |name|
  _n = name.split
  fname = _n.first(_n.count - 1).join(' ')
  lname = _n.last
  { lname: lname, fname: fname }
end

puts directors.sort_by { |n| n[:lname] }.map { |n| n[:fname] + ' ' + n[:lname] }

puts @movies.reject { |movie| movie[:Country][/USA/i] }.count

## Task3 #3
def pretty_print(movies = '')
  puts movies.map { |movie| "#{movie[:Title]} (#{movie[:PremierDate]}; #{movie[:Genre]}) - #{movie[:Duration]}" }
end

pretty_print @movies
