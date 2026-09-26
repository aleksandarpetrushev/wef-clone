module Api
  class BaseController < ActionController::API
    before_action :authenticate_user!

    private

    def current_user
      @current_user
    end

    def authenticate_user!
      user_id = request.headers["X-User-Id"].presence
      @current_user = User.find_by(id: user_id) if user_id

      return if @current_user

      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
