require_relative 'movie'

require 'csv'

class MovieCollection
  def initialize(file_name = 'movies.txt')
    abort("File with name '#{file_name}' is not exists.") unless File.exist?(file_name)

    options = {
      col_sep: '|',
      headers: %i( link title year country premierdate genre duration rating director actors)
    }

    @movies = CSV.open(file_name, options).to_a.map { |row| Movie.new row.to_h }
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort { |a, b| a.send(field.to_sym) <=> b.send(field.to_sym) }
  end

  def filter(**options)
    @movies.select { |movie| movie.send(options.keys[0])[/#{options.values[0]}/i] }
  end

  def stats(field)
    @movies.each.with_object(Hash.new(0)) do |movie, stat|
      begin
        stat[movie.send(field.to_sym)] += 1
      rescue
        stat['Undefined'] += 1
      end
    end
  end

  def to_s
    @movies.each &:to_s
  end

  def inspect
    @movies.each &:inspect
  end
end
