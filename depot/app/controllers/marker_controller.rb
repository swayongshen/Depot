class MarkerController < ApplicationController
  skip_before_action :authenticate_user!
  def index

  end

  def update
    update_params

  end

  def update_params
    params.permit(:image => [])
  end
end