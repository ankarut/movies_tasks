require_relative 'movie'
require_relative 'movie_collection'

movies = MovieCollection.new 'movies.txt'

puts movies.all.first(2)
puts movies.sort_by(:year).first(2)
puts movies.filter(genre: 'Comedy', year: 1920..1931).first(20)
puts movies.filter(year: 1920..1931, genre: 'Comedy').first(20)

puts movies.filter(director: /Cl.*e/).first(1)
puts movies.filter(director: 'Clyde Bruckman').first(1)
p movies.stats :director

puts movies.stats :drirector rescue 

puts movies.all.first.actors
puts movies.all.find { |movie| movie.has_genre?('Drama') }(2)

begin
  puts movies.all.select { |movie| movie.has_genre?('Drrama') }
rescue => e
  puts e.message
end

puts movies.all.last(2).map &:to_s
p movies.all.last(2)
puts movies.all.last(2).to_s
p movies.all.last(2)
