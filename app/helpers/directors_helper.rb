module DirectorsHelper
  def poster_for_director(director)
    image_path = director.poster.present? ? director.poster : 'missing_director.png'
    image_tag image_path
  end

end
