class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        message: "Signed up successfully",
        user: resource,
      }, status: :ok
    else
      render json: {
        message: "user could not be signed up",
        errors: resource.errors.full_messages,
        status: :unprocessable_entity
      }
    end
  end
end