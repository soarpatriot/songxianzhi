class UsersController < ApplicationController

   before_action :authenticate_user!
   before_action :load_user, only: [:edit, :show, :update, :start_shop]
   def show
   end

   def edit

   end

   def start_shop
      shop = Shop.new
      shop.save
      current_user.update shop:shop
      redirect_to edit_shop_path(shop), notice: '商店已为您开启'
   end

   def  edit_shop

   end


   def update
      if @user.update user_params
          redirect_to current_user,  notice: '资料更新成功'
      else
          render "edit"
      end
  end

   private
       def load_user
           @user = User.find(params[:id])
       end

      def user_params
        params.require(:user).permit(:id, :mobile_number,:name, :qq, :weixin, :avatar, :password, :password_confirmation, :gender)
      end
end
