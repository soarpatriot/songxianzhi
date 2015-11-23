class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception





  def current_user
    #@current_user = User.find(1)
    @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
  end
   
  def share_link_url post_url
    weixin_base = "https://open.weixin.qq.com/connect/oauth2/authorize?"
    appid= Settings.appid
    encode_url = ERB::Util.url_encode(post_url)
    # encode_url = URI.escape(redirect_url) 
    share_url = "#{weixin_base}appid=#{appid}&redirect_uri=#{encode_url}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"
    share_url
  end

  def access_token
     token = AccessToken.first
     now = DateTime.now.to_i
     if token.nil? || (now - token.updated_at.to_i) > 6000    
       wenxin_base = "https://api.weixin.qq.com/cgi-bin/token?"
       appid = Settings.appid
       secret = Settings.app_secret
       grant_type = "client_credential"
       
       url = "#{wenxin_base}appid=#{appid}&secret=#{secret}&grant_type=#{grant_type}"
   
       response = RestClient.get url 
       Rails.logger.info "response: #{response}"
       parsed = JSON.parse(response, symbolize_names:true)
       token_value = parsed[:access_token]
       token = AccessToken.first_or_create 
       token.value = token_value 
       token.save
     else 
       token_value = token.value 
     end 
     token_value
  end

  def js_ticket 
     token = access_token  
     ticket = Ticket.first 
     now = DateTime.now.to_i
     if ticket.nil? || (now - ticket.updated_at.to_i) > 6000    
       wenxin_base = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?"
       
       url = "#{wenxin_base}access_token=#{token}&type=jsapi"
   
       response = RestClient.get url 
       Rails.logger.info "response: #{response}"
       parsed = JSON.parse(response, symbolize_names:true)
       ticket = Ticket.first_or_create
       ticket_value = parsed[:ticket]
       ticket.update value: ticket_value
     else 
       ticket_value = ticket.value
     end
     ticket_value
  end

  def signature nocestr, timestamp, post_url 
    arr = []
    noce=  "noncestr=#{nocestr}"
    ticket = "jsapi_ticket=#{js_ticket}"
    timestamp ="timestamp=#{timestamp}"
    url = "url=#{post_url}"
    
    arr = [noce,ticket,timestamp,url]
    sign_oringal = arr.sort!.join("&")
    Digest::SHA1.hexdigest(sign_oringal) 
  end


  def authorize
     code =  params[:code]
     state =  params[:state]
     unless code.blank?
       wenxin_base = "https://api.weixin.qq.com/sns/oauth2/access_token?"
       user_info_base = "https://api.weixin.qq.com/sns/userinfo?access_token"
       appid = Settings.appid
       secret = Settings.app_secret
 
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
         session[:openid] = openid 
       end 
     end

  end
end
