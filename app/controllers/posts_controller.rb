class PostsController < ApplicationController
  
   def index 

   end 

   def new 
     
     code =  params[:code]
     state =  params[:state]
     wenxin_base = "https://api.weixin.qq.com/sns/oauth2/access_token?"
     appid = "wx5940611bb6faccc3"
     secret = "655870e4c49d7e85b6b2222a1ee470eb"
     grant_type = "authorization_code"
     
     url = "#{wenxin_base}appid=#{appid}&secret=#{secret}&code=#{code}&grant_type=#{grant_type}"
 

     begin
       response = RestClient.get url 
       parsed = JSON.parse(string, symbolize_names:true)
       @user = User.where(openid:parsed[:openid]).first_or_create 
       @user.update openid: parsed[openid], nickname: parsed[:nickname], sex: parsed[:sex], province: parsed[:province], city: parsed[:city], headimgurl: parsed[:headimgurl], unionid: parsed[:unionid]
       Rails.logger.info "response: #{response}"
     rescue => e
       Rails.logger.info "execption: #{e.response}"
       e.response
     end  
     

   end

   def show
   end

   def edit

   end

   def update
   end
end
