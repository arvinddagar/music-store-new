class NotifierMailer < ActionMailer::Base
 default :from => "tutor@music.com"

  def feedback_reminder(user)
    mail(:to => user.email, :subject => "Reminder")
  end
  def payment_confirmation(user)
    mail(:to => user.email, :subject => "payment confirmation")
  end
end
