file_name = ARGV[0] ? ARGV[0] : 'movies.txt'

puts "File with name '#{file_name}' is not exists." unless File.exist?(file_name)

# 1
file = File.open(file_name, 'r')
movies = file.readlines.map { |line| line.strip.split('|') }

# 2

FIELDS = {
  Title: 1,
  Rating: 7
}

def search_movies_by_title(title, movies)
  movies.select { |movie| movie[1][/#{title}/i] }
end

def get_field(field, movie)
  movie[FIELDS[field.to_sym]]
end

search_result = search_movies_by_title('Time', movies)
puts search_result.map { |movie| "#{get_field(:Title, movie)}, #{get_field(:Rating, movie)}" }

# 3
def rating_asteriscs(rating)
  _, @points = rating.split('.').map &:to_i
  asteriscs = '*' * @points
end

def pretty_space_separator
  ' ' * (10 - @points)
end

puts search_result.map { |movie| [rating_asteriscs(get_field(:Rating, movie)), get_field(:Title, movie)].join(pretty_space_separator) }

file.close
