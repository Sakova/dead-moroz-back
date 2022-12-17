class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def update
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], ENV["DEVISE_JWT_SECRET_KEY"]).first
    current_user = User.find(jwt_payload["sub"])

    user_params[:items] = JSON.parse(user_params[:items]) if user_params[:items]

    if current_user.update(user_params)
      render json: @user.reload, status: :ok
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
      render json: @user, status: :ok
    else
      render json: {
        message: "user could not be signed up",
        errors: resource.errors.full_messages,
      }, status: :unprocessable_entity
    end
  end

  def user_params
    @usr_params ||= params.permit(:name, :surname, :age, :avatar, :email, :items)
  end
end
