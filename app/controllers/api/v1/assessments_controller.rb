class Api::V1::AssessmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :allow_access?
  before_action :set_assessment, only: %i[update]

  def create
    assessment = Assessment.new(assessment_params)
    assessment.created_by = current_user.id

    if assessment.save
      render json: assessment, status: :ok
    else
      render json: {
        message: "Creation failed",
        errors: assessment.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def update
    if @assessment.update(assessment_params)
      render json: @assessment, status: :ok
    else
      render json: {
        message: "Update failed",
        errors: @assessment.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  private

  def assessment_params
    @assessment_params ||= params.permit(:star, :comment, :user_id)
  end

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end
end
