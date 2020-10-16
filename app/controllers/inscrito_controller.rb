class InscritoController < ApplicationController
    require 'jbuilder'
    def new
        @inscricao = Inscricao.new(validade_args)
        if @inscricao.save
            render json: {"status": 200}
            UserMailer.with(user: @inscricao).welcome_email.deliver_later
 
        else
            render 'erro400', status: 400, format: :jbuilder
        end
    end

    def delete
        @erros = Hash.new()
        stat = Inscricao.unsubscribe(params.permit(:id, :token), @erros)
        if stat
            render json: {"status": 200}
        else
            render 'erro403', status: 403, format: :jbuilder
        end
    end

    private
    def validade_args
        params.require(:inscrito).permit(:nome, :email, :cpf, :telefone, :ra)
    end
end
