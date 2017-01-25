module MoviesHelper
  def poster_for(movie)
    image_path = movie.poster.present? ? movie.poster : 'missing_poster.png'
    image_tag image_path
  end

  def imdb_rating_for(movie)
    twice_rating_rounded = (movie.imdb_rating * 2).round
    num_halves = twice_rating_rounded % 2 # Get the number of halves, 0 or 1

    content_tag :span, class: 'imdb_rating' do
      results = "(#{movie.imdb_rating}) "
      # Full stars
      movie.imdb_rating.round.times do
        results << fa_icon('star')
      end

      # Half star (if any)
      if num_halves > 0
        results << fa_icon('star-half-o')
      end

      # Empty stars
      (10 - (twice_rating_rounded / 2)).times do
        results << fa_icon('star-o')
      end

      results.html_safe
    end
  end
end