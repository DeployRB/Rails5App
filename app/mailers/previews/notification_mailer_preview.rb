# http://localhost:3000/rails/mailers
class NotificationMailerPreview < ActionMailer::Preview
  def test_letter
    NotificationMailer.letter('test@test.com')
  end
end
