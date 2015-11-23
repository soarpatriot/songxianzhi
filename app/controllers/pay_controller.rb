
class PayController < ApplicationController
  def index
    pay_url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
    
    #   response = RestClient.post params 
   
    r = invoke_remote pay_url, make_playload(gen_params)       
    logger.info r
  end

  def gen_params
    we_params = Hash.new
    we_params[:appid] = Settings.appid  
    we_params[:time_stamp] = Time.now.to_i
    we_params[:mch_id] = Settings.mch_id
    we_params[:nonce_str] = Settings.nonce_str 
    we_params[:body] = "order"
    we_params[:out_trade_no] = Time.now.to_i
    we_params[:total_fee] = 1
    we_params[:spbill_create_ip] = request.remote_ip
    we_params[:notify_url] = Settings.notify_url
    we_params[:openid] = session[:openid]
    we_params[:trade_type] = "JSAPI"

    we_params 
  end

  def sign_params params

      # key = params.delete(:key)

      query = params.sort.map do |key, value|
        "#{key}=#{value}" if value != "" && !value.nil?
      end.compact.join('&')

      Digest::MD5.hexdigest(query)
      # Digest::MD5.hexdigest("#{query}&key=#{key || WxPay.key}").upcase
  end

  def make_playload(params)
      logger.info "params: #{params}"
      sign = sign_params(params)
      params.delete(:key) if params[:key]
      "<xml>#{params.map { |k, v| "<#{k}>#{v}</#{k}>" }.join}<sign>#{sign}</sign></xml>"
  end
  def invoke_remote(url, payload, extra_rest_client_options = {})
      r = RestClient::Request.execute(
          method: :post,
          url: url,
          payload: payload,
          headers: { content_type: 'application/xml' }
      )

      r
  end
end
 
