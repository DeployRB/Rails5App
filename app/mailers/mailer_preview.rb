# http://localhost:3000/rails/mailers
class MailerPreview < ActionMailer::Preview
  def test_letter
    TestMailer.test_letter('test@test.com')
  end
end
