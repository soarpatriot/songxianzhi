class HomeController < ApplicationController

   def index
      weixin_base = "https://open.weixin.qq.com/connect/oauth2/authorize?"
      appid="wx5940611bb6faccc3"
      redirect_url = "http://www.cityhub.me/post"
      encode_url = URI.encode(redirect_url) 
      url = "#{weixin_base}appid=#{appid}&redirect_url=#{encode_url}&response_type=code&scope=snsapi_base&state=123#wechat_redirect"
      @weixin_url = url 
      # @categories_information = []
      # @categories_information = Information.recently
   end
   
   def about
   	 
   end
   def download
     render layout: "logo" 
   end
   def feedback

     FeedbackMailer.feed(current_user, params[:content]).deliver

     redirect_to about_path, notice: '非常感谢您的宝贵意见。'
   end
end
