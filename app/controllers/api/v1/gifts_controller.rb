class Api::V1::GiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gift, only: %i[update destroy]

  def index
    gifts = policy_scope(Gift).order(:id).page params[:page]
    render json: gifts
  end

  def create
    gift = Gift.new(gift_params)
    authorize gift
    gift.user_id = gift_params[:user_id] ? gift_params[:user_id] : current_user.id
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

  def update
    authorize @gift
    if @gift.update(gift_params)
      render json: @gift, status: :ok
    else
      render json: {
        message: "Creation failed",
        errors: @gift.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @gift
    if @gift.delete
      render json: {message: "successfully deleted"}, status: :ok
    else
      render json: {
        errors: @gift.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def set_gift
    @gift = Gift.find(params[:id])
  end

  def gift_params
    @gft_params ||= params.permit(:id, :description, :is_selected, :photo, :user_id)
  end
end
