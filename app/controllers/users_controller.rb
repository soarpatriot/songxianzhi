class UsersController < ApplicationController

   before_action :current_user

   def posts
     @posts = @current_user.posts
   end

end
