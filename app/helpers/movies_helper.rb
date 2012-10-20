module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? "odd" : "even"
  end

  def link_to_sort(cat)
    ratings = params[:ratings].nil? ? Hash.new : params[:ratings]
    new_par = {:sort => cat, :ratings => ratings}
    message = cat.eql?('title') ? "Movie title" :"Release date"
    link_to message, movies_path(new_par), :id => cat+'_header'
  end
end
