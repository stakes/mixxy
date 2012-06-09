Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '380684265312885', 'ceaceb4568d747e60ed33a818d16bdcf'
  provider :rdio, 'annhyg8fhmx2dmv3anuwd4c6', 'dNChnk5UBN'
end
