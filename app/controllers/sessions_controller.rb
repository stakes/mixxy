class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end


  def create
    auth = request.env["omniauth.auth"]
    if auth['provider'] == 'facebook'
      user = User.where(:provider => auth['provider'], 
                        :uid => auth['uid']).first || User.create_with_omniauth(auth)
      user.add_service_with_omniauth(auth['provider'], auth['credentials']['token'], auth['credentials']['secret'])
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Hi there! Welcome to Mixxy!'
    else
      logger.info auth.inspect
      current_user.add_service_with_omniauth(auth['provider'], auth['credentials']['token'], auth['credentials']['secret'], (auth.extra.user_hash.author[0].uri['$t'] if auth['provider']=='youtube'))
      
      if auth['provider'] == 'rdio'
        session[:access_token] = auth.extra.access_token
      end
      redirect_to '/me', :notice => "Awesome! Now you can start adding and sharing your #{auth['provider']} playlists!"
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
