class InfoMailer < ApplicationMailer
  def info_mail(tweet)
    # viweから参照するためにインスタンス変数へ格納
    @tweet = tweet
    mail to: User.find(tweet.user_id).email, subject: 'つぶやきました'
  end
end
