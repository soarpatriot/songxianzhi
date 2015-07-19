class FeedbackMailer < ActionMailer::Base
  default from: "soarpatriot@126.com"

  def feed(user,content)
  	@content = content
  	@use = user
  	mail(to: "85624529@qq.com", subject:"yuxian.me feedback from user")
  end
end
