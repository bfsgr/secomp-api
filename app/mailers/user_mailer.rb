class UserMailer < ApplicationMailer
    default from: 'SECOMP - UEM'
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: 'Bem vindo a SECOMP - UEM')
    end
end
