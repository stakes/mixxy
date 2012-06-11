class Support < ActionMailer::Base

  default :from => "donotreply@mixxy.co"
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
    
  def welcome_to_mixxy(user)
    @user = user

    if Rails.env == 'production'
      mail(:to => user.email,
           :subject => "Welcome to Mixxy!")
    else

      mail(:from => 'donotreply@mixxy.co',
           :to => ['drew@fullscreen.net'],
           :subject => "TEST:: this is a welcome test")
    end
  end
  
end
