class StoreController < ApplicationController
  def index
    # Gets an array of products in alphabetical order of title.
    @products = Product.order(:title)
  end
end
