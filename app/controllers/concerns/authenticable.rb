module Authenticable
  extend ActiveSupport::Concern

  private

  def authenticate_user!
    token = extract_token_from_header
    return render_unauthorized unless token

    decoded = JwtService.decode(token)
    return render_unauthorized unless decoded

    @current_user = User.find_by(id: decoded["user_id"])
    render_unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def extract_token_from_header
    auth_header = request.headers["Authorization"]
    return nil unless auth_header

    auth_header.split(" ").last if auth_header.start_with?("Bearer ")
  end

  def render_unauthorized
    render json: { errors: [ "Unauthorized" ] }, status: :unauthorized
  end
end
