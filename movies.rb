require 'date'
require 'ostruct'
require 'csv'

file_name = ARGV[0] || 'movies.txt'
abort("File with name '#{file_name}' is not exists.") unless File.exist?(file_name)

options = {
  col_sep: '|',
  headers: %i( link title year country premierdate genre duration rating director stars)
}

@movies = CSV.open(file_name, options).to_a.map { |row| OpenStruct.new row.to_h }

MAX_RATING = 10
def rating(movie)
  movie.rating.split('.').last.to_i
end

puts @movies.select { |movie| movie.title[/Time/i] }
  .map { |movie| ['*' * rating(movie), movie.title].join(' ' * (MAX_RATING - rating(movie))) }

def pretty_print(movies = '')
  puts movies.map { |movie| "#{movie.title} (#{movie.premierdate}; #{movie.genre}; #{movie.director}) - #{movie.duration}" }
end

pretty_print @movies.sort_by { |movie| movie.duration.to_i }.last(5)

pretty_print @movies.select { |movie| movie.genre[/comedy/i] }.sort_by(&:premierdate).first(10)

puts @movies.sort_by { |movie| movie.director.split.last }.map(&:director).uniq

puts @movies.reject { |movie| movie.country[/USA/i] }.count

puts @movies.each.with_object(Hash.new(0)) { |movie, stat| stat[Date::MONTHNAMES[Date.parse(movie.premierdate).month]] += 1 rescue stat['Undefined'] += 1 }
