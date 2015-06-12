module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      content_tag(:strong, "Flop!")
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag('pladerholder.jpg')
    else
      image_tag(movie.image_file_name)
    end
  end

  def format_average_stars(movie)
    if movie.average_stars.nil?
      content_tag(:strong, "No reviews")
    else
      "*" * movie.average_stars.round
    end
  end

  def low_gross_or_cult(movie)
    if movie.cult?
      "#{format_total_gross(movie)} but it is a Cult Classic"
    else
      format_total_gross(movie)
    end
  end
end
