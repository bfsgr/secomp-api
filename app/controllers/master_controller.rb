class MasterController < ApplicationController

    before_action :authenticate_request!, :except => [:authenticate_user]

    def authenticate_user
        if process_pass(params[:password])
          render json: payload(MASTER)
        else
          render json: {errors: ['Invalid Password']}, status: :unauthorized
        end
    end

    
    private
    MASTER = { id: 245, salt: ENV.fetch('PET_MASTER_SALT') , password: ENV.fetch("PET_MASTER_EPASS") }.freeze
    
    def payload(user)
        return nil unless user and user[:id]
        {
          auth_token: JsonWebToken.encode({user_id: user[:id]})
        }
    end

    def process_pass(pass)
      MASTER[:password] == BCrypt::Engine.hash_secret(pass, MASTER[:salt])
    end

end
