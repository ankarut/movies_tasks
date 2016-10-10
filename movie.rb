class Movie
  attr_reader :link, :title, :year, :country, :premierdate, :genres, :duration, :rating, :director, :actors

  @known_genres = []
  class << self; attr_accessor :known_genres; end

  def initialize(movie = {})
    movie.each_pair { |k, v| instance_variable_set("@#{k}", v) }
    @year = @year.to_i
    @actors = @actors.split(',')
    @genres = @genres.split(',')

    Movie.known_genres << @genres
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def has_genre?(genre)
    fail "Genre #{genre} is not found." unless Movie.known_genres.flatten.grep(/#{genre}/i).any?
    !!self.genres.grep(/#{genre}/i).any?
  end

  def to_s
    "#{@title} (#{@year}; #{@premierdate}; #{@genres}; #{@director};  #{@actors}) - #{@duration}"
  end

  def inspect
    "Movie(title: #{@title}, year: #{@year}, premierdate: #{@premierdate}, genre: #{@genres}, director: #{@director}, actors: #{@actors}, duration: #{@duration})"
  end
end
