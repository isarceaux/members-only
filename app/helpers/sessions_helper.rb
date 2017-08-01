module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id] #Si on a une session on fait comme avant
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:id] #Sinon si on a un cookie permanent
      user = User.find_by(id: cookies.signed[:id]) #on essaie de retrouver l'user qui correspond
      if user && user.authenticated?(cookies[:remember_token]) #si on l'a trouvé (user non nul) et le digest du cookie remember_token est le même que son remember_digest
        log_in(user) 
        @current_user = user
      end
    end
  end

  def remember(user)
    #use the User method remember
    user.remember
    #create the 2 cookies one for id and one with the remember_token
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent.signed[:id] = user.id
  end

  def forget(user)
    #use the User method forget
    user.forget
    #delete the 2 cookies
    cookies.delete(:id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
