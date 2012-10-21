class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
                            # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings

    #Manage filter session
    if params[:ratings].nil?
      if session[:ratings].nil?
        session[:ratings] = Hash[@all_ratings.map { |e| [e, 1].flatten }]
      end
    else
      session[:ratings] = params[:ratings]
    end
    @filter = session[:ratings]

    #Manage sort session
    if !params[:sort].nil?
      session[:sort] = params[:sort]
    end

    @sort = Hash.new
    if !session[:sort].nil?
      @sort[session[:sort].to_sym] = "hilite"
    end

    @movies = Movie.find_all_by_rating @filter.keys, :order => session[:sort]

    if params[:ratings].nil? || params[:sort].nil?
      redirect_to movies_path :ratings => session[:ratings], :sort => session[:sort]
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
