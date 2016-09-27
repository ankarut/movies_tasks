require_relative 'movie'

require 'csv'

OPTIONS = {
  col_sep: '|',
  headers: %i( link title year country premierdate genre duration rating director actors)
}

class MovieCollection
  def initialize(file_name = 'movies.txt')
    abort("File with name '#{file_name}' is not exists.") unless File.exist?(file_name)

    @movies = CSV.open(file_name, OPTIONS).to_a.map { |row| Movie.new row.to_h }
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort_by { |movie| movie.send(field.to_sym) }
  end

  def filter(**options)
    list = @movies
    options.each do |k, v|
      case
      when (v.is_a? Range)
        list = list.select { |item| v.to_a.any? { |value| value == (item.send(k).to_i) } }
      when (v.is_a? Regexp)
        list = list.select { |item| item.send(k).match v }
      else
        list = list.select { |item| item.send(k)[/#{v}/i] }
       end
    end
    list
  end

  def stats(field)
    @movies.each.with_object(Hash.new(0)) do |movie, stat|
      stat[movie.send(field.to_sym)] += 1
    end
  end

  def to_s
    @movies.each &:to_s
  end

  def inspect
    @movies.each &:inspect
  end
end
