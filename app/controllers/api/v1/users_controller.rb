class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :allow_access?

  def index
    users = User.all.order(:id).page params[:page]
    render json: users, status: :ok
  end
end
