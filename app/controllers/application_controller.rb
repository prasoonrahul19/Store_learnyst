class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  private
  
  def authenticate_user!
    header = request.headers['Authorization']
    Rails.logger.info "Response : #{header}"
  
    if header.present?
      token = header.split(' ').last
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id]) if decoded
  
    elsif session[:user_id]   # ✅ THIS FIXES YOUR TEST
      @current_user = User.find(session[:user_id])
  
    end
  
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end