class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    
    if (params[:ratings] == nil)
      if (session[:ratings] == nil)
        params[:ratings] = @all_ratings
      else
        params[:ratings] = session[:ratings]
      end
    else
      session[:ratings] = params[:ratings]
    end
    
    if (params[:sort] == nil)
      if (session[:sort] != nil)
        params[:sort] = session[:sort]
      end
    else
      session[:sort] = params[:sort]
    end
    
    @ratings = params[:ratings].keys
    
    @movies = Movie.where(["rating IN (?)",@ratings]).order(params[:sort])
    #@movies = Movie.find(:all, :conditions => {:rating => (@ratings==[]?all_ratings : params[:ratings])}, :order => params[:sort])
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    flash.keep
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    flash.keep
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    flash.keep
    redirect_to movies_path
  end

end
