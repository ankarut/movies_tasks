class Movie

  attr_reader :link, :title, :year, :country, :premierdate, :genre, :duration, :rating, :director, :actors
  
  @known_genres = []
  class << self; attr_accessor :known_genres; end

  def initialize(movie = {})
    movie.each_pair { |k, v| instance_variable_set("@#{k}", v) }

    Movie.known_genres << @genre
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end
  
  def has_genre?(genre)
    fail "Genre #{genre} is not found." unless Movie.known_genres.include?(genre)
    !!self.genre[/#{genre}/i]
  end

  def to_s
    "#{@title} (#{@year}; #{@premierdate}; #{@genre}; #{@director};  #{@actors}) - #{@duration}"
  end

  def inspect
    "Movie(title: #{@title}, year: #{@year}, premierdate: #{@premierdate}, genre: #{@genre}, director: #{@director}, actors: #{@actors}, duration: #{@duration})"
  end
end
