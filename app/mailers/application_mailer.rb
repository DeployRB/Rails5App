class ApplicationMailer < ActionMailer::Base
  default from: Settings.app.mailer.smtp.default.user_name
  prepend_view_path Rails.root.join('app/mailers/views')
  layout 'layouts/mailer_slim'

  def self.smtp?
    Settings.app.mailer.service == 'smtp'
  end

  private

  def set_attachments!
    attached_image_name = 'attached_image.png'
    attached_image_path = 'ruby.png'
    attached_image_path = "#{ Rails.root }/public/static/images/#{ attached_image_path }"

    attachments.inline[attached_image_name] = File.read(attached_image_path)
  end
end
