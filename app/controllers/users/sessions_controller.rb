class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    render json: current_user, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], ENV["DEVISE_JWT_SECRET_KEY"]).first
    current_user = User.find(jwt_payload["sub"])
    if current_user
      render json: {
        message: "Signed out successfully"
      }, status: :ok
    else
      render json: {
        message: "User has no active session"
      }, status: :unauthorized
    end
  end
end
