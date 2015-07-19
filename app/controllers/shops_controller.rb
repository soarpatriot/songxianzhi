class ShopsController < ApplicationController

   before_action :load_shop, only: [:show, :information]

   def index
        @shops = Shop.page params[:page]
   end

   def show
       @information = @shop.information.page params[:page]
   end

   def load_shop

       @shop = nil
       @shop = Shop.where(url:params[:id]).first  unless params[:id].nil?
       if @shop.nil?
         @shop = Shop.find(params[:id])
       end

   end

   def my_shop

     @shop = Shop.where(url:request.subdomain).first
     @information = @shop.information.page params[:page]
     render "show"
   end

   def information
     @comment = Comment.new # @information.comments.build
     @information = Information.find(params[:information_id])
     @category = Category.find(params[:category_id]) unless params[:category_id].nil?
     @comments = @information.comments.page params[:page]
     @information.increment_visit_count
      # @information = Information.find(params[:information_id])
   end
end
