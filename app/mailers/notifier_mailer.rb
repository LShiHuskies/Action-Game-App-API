class NotifierMailer < ApplicationMailer

    def welcome_email(recipient)
        @user = recipient
        mail(
            to: @user.email,
            subject: "Welcome to The Game!",
            content_type: "text/html"
        )
      end

      def reset_email(recipient)
        @user = recipient
        mail(
            to: @user.email,
            subject: "Password Reset",
            content_type: "text/html"
        )
      end

      def update_account_notify(recipient)
        @user = recipient
        mail(
            to: @user.email,
            subject: "Account Updated",
            content_type: "text/html"
        )
      end
end
