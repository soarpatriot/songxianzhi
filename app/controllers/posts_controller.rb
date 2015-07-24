class PostsController < ApplicationController
  
   def index 

   end 

   def new 
     
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

     user_info_url ="#{user_info_base}=#{access_token}&openid=#{openid}&lang=zh_CN"
     
     user_info_response = RestClient.get user_info_url
     user_data = JSON.parse(user_info_response, symbolize_names:true)

     @user = User.where(openid:user_data[:openid]).first_or_create 
     @user.update openid: user_data[:openid], nickname: user_data[:nickname], sex: user_data[:sex], province: user_data[:province], city: user_data[:city], headimgurl: user_data[:headimgurl], unionid: user_data[:unionid]
   

   end

   def show
   end

   def edit

   end

   def update
   end
end
