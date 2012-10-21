module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? "odd" : "even"
  end

  def link_to_sort(cat)
    message = cat.eql?('title') ? "Movie title" :"Release date"
    link_to message, movies_path(:sort => cat), :id => cat+'_header'
  end
end
