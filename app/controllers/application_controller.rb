class ApplicationController < ActionController::API
    attr_reader :logged

    protected
    def authenticate_request!
        unless user_id_in_token?
            render "inscrito/erro401", status: :unauthorized, format: :jbuilder
            return
        end
        rescue JWT::VerificationError, JWT::DecodeError
            render json: "inscrito/erro401", status: :unauthorized, format: :jbuilder
    end
    
    private
    def http_token
        @http_token ||= if request.headers['Authorization'].present?
            request.headers['Authorization'].split(' ').last
        end
    end
    
    def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
    end
    
    def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
    end
end
