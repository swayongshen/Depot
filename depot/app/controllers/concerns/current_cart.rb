module CurrentCart
  private
  # Tries to find the cart with cart_id that is stored in the session. If no such
  # cart, create a new cart and store cart_id in session.
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end