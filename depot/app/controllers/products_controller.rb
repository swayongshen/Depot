class ProductsController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_product_and_check_owner, only: %i[ edit update destroy ]
  before_action :set_cart

  # GET /products or /products.json
  def index
    set_products
  end

  # GET /products/1 or /products/1.json
  def show
    set_product
  end

  # GET /products/new
  def new
    @product = Product.new
    set_genre_names
  end

  # GET /products/1/edit
  def edit
    set_genre_names
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params.except(:genre_names))
    @product.user_id = current_user.id
    new_clean_up_genre_param

    respond_to do |format|
      if @product.save
        set_products
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.js { render :update}
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      update_clean_up_genre_aram
      if @product.update(product_params.except(:genre_names))
        puts "SAVED"
        puts @product
        puts @product.genres.size
        @products = Product.all
        ActionCable.server.broadcast 'products',
                                     html: render_to_string('store/index', layout: false)
        set_products
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.js
        format.json { render :show, status: :ok, location: @product }

      else
        set_genre_names
        format.html { render :edit, status: :unprocessable_entity }
        format.js{ render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    respond_to do |format|
      is_destroyed = @product.destroy
      user_products_getter = Thread.new { Thread.current[:output] = set_products }
      user_products_getter.join
      @products = user_products_getter[:output]

      if is_destroyed
        format.html { redirect_to products_url, notice: "Product was successfully deleted." }
        format.js { render 'update.js.erb'}
        format.json { head :no_content }
      else
        @notice = "Cannot delete product, it is being referenced by a line item."
        flash.now[:notice] = @notice
        format.html { redirect_to products_url }
        format.js { render 'update.js.erb', status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_and_check_owner
      begin
        @product = Product.find(params[:id])
        if @product.user != current_user
          unauthorised_access
        end
      rescue ActiveRecord::RecordNotFound
        unauthorised_access
      end
    end

    def set_product
      begin
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        unauthorised_access
      end
    end

  # Get all unique genre names used by all products for the user to choose from
    def set_genre_names
      @genre_names = Genre.distinct.pluck(:name)
    end

    def set_products
      @products = Product.includes('user').where(users: current_user).order(:title)
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :genre_names => [], :product_images => [],
                                      :best_seller_rankings_attributes => [:id, :category, :rank, :_destroy])
    end

    def unauthorised_access
      flash[:alert] = "You are not authorised to handle product id:#{params[:id]}"
      flash.keep
      redirect_to products_url
    end

    # Use new to create new genres and attach it to the new product and save it together with the product
    def new_clean_up_genre_param
      filter_genres_empty_string = params[:product][:genre_names].select{ |genre_name| genre_name != "" }
      @product.new_genres_if_not_exist(filter_genres_empty_string)
    end

    # Creates and saves genres and attach them to the product.
    def update_clean_up_genre_aram
      filter_genres_empty_string = params[:product][:genre_names].select{ |genre_name| genre_name != "" }
      @product.create_genres_if_not_exist(filter_genres_empty_string)
    end
end
