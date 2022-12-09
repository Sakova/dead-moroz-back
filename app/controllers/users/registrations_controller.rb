class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def update
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], ENV["DEVISE_JWT_SECRET_KEY"]).first
    current_user = User.find(jwt_payload["sub"])

    if current_user.update(user_params)
      render json: {
        message: "Update successfully",
        user: current_user,
        params: account_update_params
      }, status: :ok
    else
      render json: {
        message: "Update failed",
        errors: resource.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

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
      }, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(:name, :surname, :age, :avatar, :street, :house, :floor, :email)
  end
end
