class MasterController < ApplicationController

    before_action :authenticate_request!, :except => [:authenticate_user]

    def authenticate_user
        if process_pass(params[:password])
          render json: payload(MASTER)
        else
          render json: { status: 401 , erros: ['Invalid Password']}, status: :unauthorized
        end
    end


    def list
      inscritos = Inscricao.select(:id, :nome, :email ,:cpf, :ra) 
      render json: inscritos, status: :ok
    end

    def get_inscrito
      inscrito = Inscricao.find(params[:id])
      render json: inscrito, status: :ok
      rescue ActiveRecord::RecordNotFound, ActiveRecord::StatementInvalid
        render 'inscrito/erro404', status: :not_found, format: :jbuilder, controller: 'inscrito'
        
    end

    def remove
      Inscricao.delete(params[:id])
      render json: { status: 200 }, status: :ok
      rescue ActiveRecord::RecordNotFound, ActiveRecord::StatementInvalid
        render 'inscrito/erro404', status: :not_found, format: :jbuilder, controller: 'inscrito'
    end

    
    private
    MASTER = { id: 245, salt: ENV.fetch('PET_MASTER_SALT') , password: ENV.fetch("PET_MASTER_EPASS") }.freeze
    
    def payload(user)
        return nil unless user and user[:id]
        {
          status: 200,
          auth_token: JsonWebToken.encode({user_id: user[:id]})
        }
    end

    def process_pass(pass)
      MASTER[:password] == BCrypt::Engine.hash_secret(pass, MASTER[:salt])
    end

end
