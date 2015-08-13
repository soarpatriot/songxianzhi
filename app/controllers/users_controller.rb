class UsersController < ApplicationController


   def posts 
     @posts = @user.posts
   end
end
