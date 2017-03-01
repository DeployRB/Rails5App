class EcommerceMailer < ApplicationMailer
  before_action :set_attachments!

  if smtp?
    default from: Settings.app.mailer.smtp.ecommerce.user_name

    def self.smtp_settings
      Settings.app.mailer.smtp.ecommerce.to_h
    end
  end

  # EcommerceMailer.letter('test@test.com').deliver_now
  def letter(receiver_email)
    mail(to: receiver_email,
      subject: 'Ecommerce Mailer Letter',
      template_path: 'notification_mailer',
      template_name: 'letter'
    )
  end
end
