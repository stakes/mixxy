Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_KEY"], ENV["FACEBOOK_APP_SECRET"], {:scope => "publish_actions"}
  provider :rdio, ENV["RDIO_APP_KEY"], ENV["RDIO_APP_SECRET"]
  provider :youtube, ENV["YOUTUBE_APP_KEY"], ENV["YOUTUBE_APP_SECRET"]
  provider :soundcloud, ENV["SC_APP_KEY"], ENV["SC_APP_SECRET"]
end
