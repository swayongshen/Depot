class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!, only: [:index, :show, :update, :ship]
  before_action :set_cart, only: [:new, :create, :index]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: %i[ show edit update destroy ship]



  def filter
    puts "FILTER"
    respond_to do |format|
      @orders = Order.where(nil)
      @orders = @orders.where(email: params[:email]) if params[:email].present?
      @orders = @orders.where(address: params[:address]) if params[:address].present?
      unless params[:email].present? or params[:address].present?
        @orders = Order.none
      end
      puts @orders
      format.html { render :index }
      format.js
    end
  end

  # GET /orders or /orders.json
  def index
    puts filter_orders_url
    puts "INDEX"
    @orders = User.get_all_orders_by_user(current_user)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @orders = Order.find_by(id: params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end


  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderMailer.received(@order).deliver_later
        format.html { redirect_to store_index_url, notice:
          'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        @orders = User.get_all_orders_by_user(current_user)
        format.js
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def ship
    respond_to do |format|
      if @order.mark_user_products_shipped(current_user)
        OrderMailer.shipped(@order, current_user).deliver_later
        format.html { redirect_to @order, notice: "Successfully marked order as shipped." }
        @orders = User.get_all_orders_by_user(current_user)
        format.js { render 'update' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      begin
        @order = Order.where(id: params[:id]).first
        unless is_authorised?(@order)
          unauthorised_access
        end
      rescue ActiveRecord::RecordNotFound
        unauthorised_access
      end
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :shipped)
    end

    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: 'Your cart is empty'
      end
    end

    def filter_params
      params.permit(:name, :address, :email, :pay_type, :shipped)
    end


    def invalid_order
      logger.error "Attempted to access invalid order #{params[:id]}"
      redirect_to orders_url, notice: 'Invalid order'
    end

    def unauthorised_access
      flash[:error] = "You are not authorised to handle order id:#{params[:id]}"
      flash.keep
      redirect_to orders_url
    end

    def is_authorised?(order)
      @order = order
      @order.ordered_line_items_of_user(current_user).size > 0
    end
end
