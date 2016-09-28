class Movie
  attr_reader :link, :title, :year, :country, :premierdate, :genre, :duration, :rating, :director, :actors

  def initialize(movie = {})
    movie.each_pair { |k, v| instance_variable_set("@#{k}", v) }
  end

  def has_genre?(genre)
    !!self.genre[/#{genre}/i]
  end

  def to_s
    "#{@title} (#{@year}; #{@premierdate}; #{@genre}; #{@director};  #{@actors}) - #{@duration}"
  end

  def inspect
    "Movie(title: #{@title}, year: #{@year}, premierdate: #{@premierdate}, genre: #{@genre}, director: #{@director}, actors: #{@actors}, duration: #{@duration})"
  end
end
