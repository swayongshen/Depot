class GenresController < ApplicationController
  before_action :set_genre, except: [:create, :index]

  def create
    if request.get?
      @genre = Genre.new
    elsif request.post?
      @genre = Genre.new(genre_params)
      @genre.name = @genre.name.downcase
      respond_to do |format|
        if Genre.select(:name).where("name = ?", @genre.name).size == 0
          if @genre.save
            flash[:notice] = "Genre was successfully added."
            format.html {redirect_to :genres}
          else
            format.html {render :create, status: :unprocessable_entity}
          end
        else
          flash[:alert] = "Genre with the same name already exists"
          format.html {render :create }
        end
      end
    end
  end


  def edit
    if request.patch?
      respond_to do |format|
        if Genre.where("name = ?", params[:genre][:name]).first.id == @genre.id
          if @genre.update(genre_params)
            flash[:notice] = "Genre was successfully updated."
            format.html {redirect_to :genres}
          else
            format.html {render :edit, status: :unprocessable_entity}
          end
        else
          flash[:alert] = "Genre with the same name already exists"
          format.html {render :edit }
        end
      end
    end
  end


  def delete

  end

  def show
  end

  def index
    @genres = Genre.all
  end



  private
  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end
