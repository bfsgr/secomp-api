
class CPFValidator < ActiveModel::Validator
    def validate(record)
        require "cpf_cnpj"
        if options[:fields].any?{ |field| not CPF.valid?(record.send(field)) }
            record.errors[:cpf] << "CPF inválido"
        end
    end
  end

class Inscricao < ApplicationRecord
    # antes de criar uma nova inscrição crie uma string base64 para remoção
    before_create :gen_unsubscribe_token, :normalize

    # valida nome, ra e email
    validates :nome, :presence => true, :length => { :in => 1..255 }
    validates :ra, :length => { is: 6 }, :allow_blank => true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    # valida o campo de CPF usando a gem cpf_cnpj
    validates_with CPFValidator, fields: [:cpf]
    validates :cpf, uniqueness: true

    # função de desinscrição
    def self.unsubscribe(request, erros)
        # busca no banco o usuário com o ID
        inscrito = self.find(request[:id])
        # verificação desnecessária? se o id não existir a chamada anterior retorna 404
        if not inscrito.nil? 
            # se o token na query for igual ao do banco, remova o inscrito
            if inscrito.unsubscribe_token == request[:token]
                inscrito.delete
                return true
            end
            # caso contrátio gere uma mensagem de erro no token e retorne false
            erros[:token] = [ "Token de desinscrição inválido" ]
            return false
        end
    end



    private
    # crie o token base64 do usuário
    def gen_unsubscribe_token
        self.unsubscribe_token = SecureRandom.urlsafe_base64.to_s
    end

    def normalize
        require "cpf_cnpj"
        aux = CPF.new(self.cpf)
        self.cpf = aux.formatted
    end
end
