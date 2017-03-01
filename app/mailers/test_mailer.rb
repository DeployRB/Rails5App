class TestMailer < ActionMailer::Base
  layout 'mailer_slim'

  before_action :set_attachments!

  def self.smtp?
    Settings.app.mailer.service == 'smtp'
  end

  if smtp?
    default from: Settings.app.mailer.smtp.default.user_name

    def self.smtp_settings
      Settings.app.mailer.smtp.default.to_h
    end
  end

  # TestMailer.test_letter.deliver_now
  def test_letter(receiver_email)
    mail(to: receiver_email, subject: 'Test Mailer Letter')
  end

  private

  def set_attachments!
    attached_image_name = 'attached_image.png'
    attached_image_path = 'ruby.png'
    attached_image_path = "#{ Rails.root }/public/static/images/#{ attached_image_path }"

    attachments.inline[attached_image_name] = File.read(attached_image_path)
  end
end
