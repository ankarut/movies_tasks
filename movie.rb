class Movie
  def initialize(movie = {})
    movie.each_pair do |k, v|
      instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc { instance_variable_get("@#{k}") })
      self.class.send(:define_method, "#{k}=", proc { |v| instance_variable_set("@#{k}", v) })
    end
  end

  def has_genre?(genre)
    self.genre[/#{genre}/i] ? true : fail("Genre '#{genre}' is not found.")
  end

  def to_s
    "#{@title} (#{@year}; #{@premierdate}; #{@genre}; #{@director};  #{@actors}) - #{@duration}"
  end

  def inspect
    "Movie(title: #{@title}, year: #{@year}, premierdate: #{@premierdate}, genre: #{@genre}, director: #{@director}, actors: #{@actors}, duration: #{@duration})"
  end
end
