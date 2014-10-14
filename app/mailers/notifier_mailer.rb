class NotifierMailer < ActionMailer::Base
 
 default :from => "tutor@music.com"

  def feedback_reminder(user)
    mail(:to => user.email, :subject => "Reminder")
  end

  def payment_confirmation(user)
    mail(:to => user.email, :subject => "payment confirmation")
  end
  
  def reservation_confirmation(user)
    mail(:to => user.email, :subject => "payment confirmation")
  end
  
  def admin_confirmation(user)
    mail(:to => user, :subject => "payment confirmation")
  end

  def lesson_confirmation(user)
    mail(:to => user.email, :subject => "new lesson from your favorite teacher")
  end


  def reschedule_student_confirmation(user)
    mail(:to => user.email, :subject => "Reschedule of your class")
  end


  def reservation_tutor_confirmation(user)
    mail(:to => user.email, :subject => "Reschedule of your class")
  end
  
end