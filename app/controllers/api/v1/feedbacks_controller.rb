class Api::V1::FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feedback, only: %i[update]

  def create
    feedback = Feedback.new(feedback_params)
    authorize feedback
    feedback.created_by = current_user.id

    if feedback.save
      render json: feedback, status: :ok
    else
      render json: {
        message: "Creation failed",
        errors: feedback.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def update
    authorize @feedback
    if @feedback.update(feedback_params)
      render json: @feedback, status: :ok
    else
      render json: {
        message: "Update failed",
        errors: @feedback.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    @feedback_params ||= params.permit(:review, :user_id)
  end

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end
end
