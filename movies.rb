MAX_RATING = 10
FIELDS = %i{ Link Title Year Country PremierDate Genre Duration Rating Director Stars}
DEFAULT_FILE = 'movies.txt'

def search_movies_by_title(title)
  @movies.select { |movie| movie[:Title][/#{title}/i] }
end

def rating_asteriscs(movie)
  _, @points = movie[:Rating].split('.').map &:to_i
  asteriscs = '*' * @points
end

def pretty_space_separator
  ' ' * (MAX_RATING - @points)
end


# 4-5
file_name = ARGV[0] ? ARGV[0] : DEFAULT_FILE
puts "File with name '#{file_name}' is not exists." unless File.exist?(file_name)

# 1
file = File.open(file_name, 'r')
@movies = file.readlines.map { |line| Hash[FIELDS.zip(line.strip.split('|'))] }

# 2
search_result = search_movies_by_title('Time')
puts search_result.map { |movie| "#{ movie[:Title] }, #{movie[:Rating] }" }

# 3
puts search_result.map { |movie| [rating_asteriscs(movie), movie[:Title] ].join(pretty_space_separator) }

file.close



