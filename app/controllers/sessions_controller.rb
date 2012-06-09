class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end


  def create
    auth = request.env["omniauth.auth"]
    if auth['provider'] == 'facebook'
      user = User.where(:provider => auth['provider'], 
                        :uid => auth['uid']).first || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Signed in!'
    else
      puts auth.credentials.inspect
      current_user.add_service_with_omniauth(auth['provider'], auth['credentials']['token'], auth['credentials']['secret'])
      redirect_to root_url, :notice => 'Added auth!'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
