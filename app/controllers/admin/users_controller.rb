class Admin::UsersController < Admin::AdminController

   before_action :load_user, only: [:edit, :show, :update,:destroy]
   def index
       @users = User.page params[:page]
   end
   def show

   end

   def edit

   end

   def destroy
      @user.destroy
      redirect_to admin_users_path, notice: '用户删除成功'
   end
   def update
      if @user.update user_params
          redirect_to current_user
      else
          render "edit"
      end
  end

   private
       def load_user
           @user = User.find(params[:id])
       end

      def user_params
        params.require(:user).permit(:id, :mobile_number,:name, :qq, :weixin, :avatar, :password, :password_confirmation)
      end
end
