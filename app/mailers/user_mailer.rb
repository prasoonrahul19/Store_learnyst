class UserMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: " Hola 😎, Welcome to our platform 🎉")
    end
end