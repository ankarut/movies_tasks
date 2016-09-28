require_relative 'movie'

require 'csv'

class MovieCollection
  OPTIONS = {
    col_sep: '|',
    headers: %i( link title year country premierdate genre duration rating director actors)
  }

  def initialize(file_name = 'movies.txt')
    abort("File with name '#{file_name}' is not exists.") unless File.exist?(file_name)
    @movies = CSV.open(file_name, OPTIONS).map(&:to_h).map(&Movie.method(:new))
  end

  def all
    @movies
  end

  def sort_by(field)
    @movies.sort_by(&field.to_sym)
  end

  def filter(**options)
    options.reduce(@movies) do |list, (k, v)|
      case v
      when Range
        list = list.select { |item| v === item.send(k).to_i }
      when Regexp, String
        list = list.select { |item| item.send(k)[v] }
       end
    end
  end

  def stats(field)
    @movies.group_by { |movie| movie.send(field.to_sym) }.map { |k, v| [k, v.count] }.to_h
  end

  def to_s
    @movies.each &:to_s
  end

  def inspect
    @movies.each &:inspect
  end
end
