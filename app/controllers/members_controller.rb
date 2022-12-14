class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      user: current_user,
      address: current_user.address
    }, status: :ok
  end
end