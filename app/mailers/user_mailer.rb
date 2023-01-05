class UserMailer < ApplicationMailer
  def job_alert(user)
    @user = user
    mail to: user.email
  end
end
