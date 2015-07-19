class I::BaseController < ApplicationController
  before_action :authenticate_user!
  layout "users"
end
