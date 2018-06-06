module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def redirect_to_log_in
    if current_user.nil?
      redirect_to new_session_path
    elsif current_user.id != params[:user_id]
      redirect_to '/'
    end
  end
end
