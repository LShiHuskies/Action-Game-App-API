class NotifierMailer < ApplicationMailer

    def account_activation(recipient)
        @user = recipient
        
        mail to: @user.email, subject: "Account Activation"
    end

    def welcome_email(recipient)
        @user = recipient
        mail(
            to: @user.email,
            subject: "Welcome to The Game!",
            content_type: "text/html"
        )
      end

      def send_game_email(recipient, otherPlayer, game)
        @user = recipient
        @user2 = otherPlayer
        @game = game

        mail(
            to: [@user.email, @user2.email],
            subject: "Your Game Information",
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
