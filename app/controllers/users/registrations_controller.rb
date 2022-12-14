class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def update
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], ENV["DEVISE_JWT_SECRET_KEY"]).first
    current_user = User.find(jwt_payload["sub"])

    user_params[:items] = JSON.parse(user_params[:items]) if user_params[:items]

    if current_user.update(user_params)
      Address.upsert({street: address_params[:street], house: address_params[:house], floor: address_params[:floor], user_id: current_user.id})
      render json: {
        message: "Update successfully",
        user: current_user,
        address: current_user.address,
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
    @usr_params ||= params.permit(:name, :surname, :age, :avatar, :email, :items)
  end

  def address_params
    @addr_params ||= params.permit(:street, :house, :floor)
  end
end
