MAX_RATING = 10
FIELDS = %i{ Link Title Year Country PremierDate Genre Duration Rating Director Stars}
DEFAULT_FILE = 'movies.txt'

def rating(movie)
  movie[:Rating].split('.').last.to_i
end	

# 4-5
file_name = ARGV[0] || DEFAULT_FILE
abort("File with name '#{file_name}' is not exists.")  unless File.exist?(file_name)

# 1
@movies = File.readlines(file_name).map { |line| FIELDS.zip(line.strip.split('|')).to_h }

# 2
search_result = @movies.select { |movie| movie[:Title][/Time/i] }
puts search_result.map { |movie| "#{ movie[:Title] }, #{movie[:Rating] }" }

# 3
puts search_result.map { |movie| [ '*' * rating(movie), movie[:Title] ].join(' ' * (MAX_RATING - rating(movie)) ) }
