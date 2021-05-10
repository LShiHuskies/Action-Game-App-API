class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULTEMAIL']
  layout 'mailer'
end
