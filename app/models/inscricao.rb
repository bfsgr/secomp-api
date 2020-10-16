
class CPFValidator < ActiveModel::Validator
    def validate(record)
        require "cpf_cnpj"
        if options[:fields].any?{ |field| not CPF.valid?(record.send(field)) }
            record.errors[:cpf] << "CPF inválido"
        end
    end
  end

class Inscricao < ApplicationRecord

    before_create :gen_unsubscribe_token

    validates :nome, :presence => true, :length => { :in => 1..255 }
    validates :ra, :length => { is: 6 }, :allow_blank => true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates_with CPFValidator, fields: [:cpf]

    phony_normalize :telefone, default_country_code: 'BR'
    validates :telefone, :phony_plausible => { :message => "Telefone inválido"}

    def self.unsubscribe(request, erros)
        inscrito = self.find(request[:id])
        if not inscrito.nil? 
            if inscrito.unsubscribe_token == request[:token]
                inscrito.delete
                return true
            end
            erros[:token] = Array.new()
            erros[:token] << "Token de desinscrição inválido"
            return false
        end
    end

    private
    def gen_unsubscribe_token
        self.unsubscribe_token = SecureRandom.urlsafe_base64.to_s
    end
end
