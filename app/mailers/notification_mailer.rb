class NotificationMailer < ApplicationMailer
  before_action :set_attachments!

  if smtp?
    default from: Settings.app.mailer.smtp.default.user_name

    def self.smtp_settings
      Settings.app.mailer.smtp.default.to_h
    end
  end

  # NotificationMailer.letter('test@test.com').deliver_now
  def letter(receiver_email)
    mail(to: receiver_email, subject: 'Notification Mailer Letter')
  end
end
