class Admin::AdminController < ApplicationController

  layout "admins"
  before_filter :authenticate_admin!

end
