# http://localhost:3000/rails/mailers
class EcommerceMailerPreview < ActionMailer::Preview
  def letter
    EcommerceMailer.letter('test@test.com')
  end
end
