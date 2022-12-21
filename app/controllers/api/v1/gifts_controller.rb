class Api::V1::GiftsController < ApplicationController
  before_action :authenticate_user!

  def index
    gifts = current_user.gifts
    render json: gifts
  end
  def create
    gift = Gift.new(gift_params)
    gift.user_id = current_user.id
    gift.created_by = current_user.user? ? 0 : 1

    if gift.save
      render json: gift, status: :ok
    else
      render json: {
        message: "Creation failed",
        errors: gift.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  private

  def gift_params
    @gft_params ||= params.permit(:description, :is_selected, :photo)
  end
end
