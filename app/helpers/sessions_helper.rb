module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_to_logg_in
    redirect_to new_session_path if current_user.nil?
  end
end
