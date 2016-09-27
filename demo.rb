require_relative 'movie'
require_relative 'movie_collection'

movies = MovieCollection.new 'movies.txt'

puts movies.all.first(2)
puts movies.sort_by(:year).first(2)
puts movies.filter(genre: 'Comedy', year: 1920..1931).first(20)
puts movies.filter(year: 1920..1931, genre: 'Comedy').first(20)
puts movies.filter(director: /Cl.*e/).first(20)

puts movies.stats :director
# puts movies.stats :drirector

puts movies.all.first.actors
puts movies.all.first.has_genre? 'Drama'

begin
  puts movies.all.each { |movie| movie.has_genre?('Tragedy') }
rescue => e
  puts e
end

puts movies.all.last(2).map &:to_s
p movies.all.last(2)
puts movies.all.last(2).to_s
p movies.all.last(2)