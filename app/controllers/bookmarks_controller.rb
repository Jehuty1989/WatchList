class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  # list = List.where('id = ?', @bookmark.list_id)

  def create
    # if @bookmark.nil?
    #   @list = List.find(params[:list_id])
    #   @movies = Movie.all
    #   @bookmark = Bookmark.new
    #   render '/lists/show'
    # end

    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list_id = @list.id
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark.movie_id = @movie.id

    if @bookmark.save
      redirect_to list_path(@list)
    else
      @movies = Movie.all
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # @list = Movie.find(@bookmark.list_id)

    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
