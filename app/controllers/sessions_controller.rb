class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id   # ✅ for RSpec

      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        token: token,
        user: {
          id: user.id,
          email: user.email
        }
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end