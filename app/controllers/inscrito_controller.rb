class InscritoController < ApplicationController
    #POST /inscreve
    def new
        # nova inscrição com os parametros permitidos da payload
        @inscricao = Inscricao.new(validade_args)
        if @inscricao.save
            # Se salvar retorne o status e envie o email confirmando o cadastro
            render json: {"status": 200}
            UserMailer.with(user: @inscricao).welcome_email.deliver_later
 
        else
            # Não salvou, retorne 400 e construa a mensagem de erro
            render 'erro400', status: 400, format: :jbuilder
        end
    end

    #DELETE /desinscreve?:id&:token
    def delete
        #hask para erros
        @erros = Hash.new()
        # chama o processo de remoção com id e token e o hash de erros
        stat = Inscricao.unsubscribe(params.permit(:id, :token), @erros)
        if stat
            # se remover retorne 200
            render json: {"status": 200}
        else
            # se não o token é inválido, construa uma mensagem 403
            render 'erro403', status: 403, format: :jbuilder
        end
    end

    private
    # permita os argumentos de inscrição da payload
    def validade_args
        params.require(:inscrito).permit(:nome, :email, :cpf, :ra)
    end
end
