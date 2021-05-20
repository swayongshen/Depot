class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_product_and_check_owner, only: %i[ edit update destroy ]
  before_action :set_product, only: [:show]

  # GET /products or /products.json
  def index
    set_products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

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
      if @product.update(product_params)
        @products = Product.all
        ActionCable.server.broadcast 'products',
                                     html: render_to_string('store/index', layout: false)
        set_products
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.js
        format.json { render :show, status: :ok, location: @product }

      else
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

    def set_products
      @products = Product.includes('user').where(users: current_user).order(:title)
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :price, :product_type, :product_images => [])
    end

    def unauthorised_access
      flash[:alert] = "You are not authorised to handle product id:#{params[:id]}"
      flash.keep
      redirect_to products_url
    end
end
