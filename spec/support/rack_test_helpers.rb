module RackTestHelpers
  def app
    Rails.application
  end

  def current_user
    @user ||= create :user
  end

  def current_token
    @token ||= current_user.auth_tokens.create
  end

  def json_post url, data={}
    post url, data
    JSON.parse last_response.body, symbolize_names: true
  end

  def json_get url, data={}
    get url, data
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_get url, data={}
    get url, data.merge(auth_token: current_token.value)
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_post url, data={}
    post url, data.merge(auth_token: current_token.value)
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_put url, data={}
    put url, data.merge(auth_token: current_token.value)
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_delete url, data={}
    delete url, data.merge(auth_token: current_token.value)
    JSON.parse last_response.body, symbolize_names: true
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RackTestHelpers
end
