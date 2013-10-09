class GroupMailer < ActionMailer::Base
  default from: "app18565578@heroku.com"

  def recipient_email(giver, receiver)
    @giver = giver
    @receiver = receiver
    mail(to: @giver.email, subject: "Hey #{@giver.first_name}, you have a secret santa")
  end
end
