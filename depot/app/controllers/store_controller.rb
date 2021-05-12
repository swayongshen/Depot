class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authenticate_user!
  before_action :set_cart

  def index
    # Gets an array of products in alphabetical order of title.
    @products = Product.order(:title)
  end
end
