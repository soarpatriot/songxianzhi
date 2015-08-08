class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource



  protected
  def layout_by_resource
    if devise_controller?
      if resource_name == :admin
        "admins"
      end
    end
  end


  def current_user
    @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
  end

  def authorize
     code =  params[:code]
     state =  params[:state]
     wenxin_base = "https://api.weixin.qq.com/sns/oauth2/access_token?"
     user_info_base = "https://api.weixin.qq.com/sns/userinfo?access_token"
     appid = "wx5940611bb6faccc3"
     secret = "655870e4c49d7e85b6b2222a1ee470eb"
     grant_type = "authorization_code"
     
     url = "#{wenxin_base}appid=#{appid}&secret=#{secret}&code=#{code}&grant_type=#{grant_type}"
 
     response = RestClient.get url 
     Rails.logger.info "response: #{response}"
     parsed = JSON.parse(response, symbolize_names:true)
     access_token = parsed[:access_token]
     openid = parsed[:openid]

     unless openid.nil?
       user_info_url ="#{user_info_base}=#{access_token}&openid=#{openid}&lang=zh_CN"
       
       user_info_response = RestClient.get user_info_url
       user_data = JSON.parse(user_info_response, symbolize_names:true)

       @user = User.where(openid:user_data[:openid]).first_or_create 
       @user.update openid: user_data[:openid], nickname: user_data[:nickname], sex: user_data[:sex], province: user_data[:province], city: user_data[:city], headimgurl: user_data[:headimgurl], unionid: user_data[:unionid]
       session[:user_id] = @user.id 
     end 


  end
end
