require "base64"

module Api
  class CnabController < ApplicationController
    before_action :authenticate

    def index
      render json: {teste: 'Teste'}
    end

    def create
      begin
        file = Base64.decode64(params[:file])

        lines = file.split(/\n+|\r+/).reject(&:empty?)

        lines.each_with_index { | x, i |
          
          tipo = x[0]
          data = x[1..8]
          valor = x[9..18]
          cpf = x[19..29]
          cartao = x[30..41]
          hora = x[42..47]
          nome_dono = x[48..61]
          nome_loja = x[62..80]
          
          if data =~ /^(\d{4})(\d{2})(\d{2})$/
            data_formatada = "#{$1}-#{$2}-#{$3}"
          end

          if hora =~ /^(\d{2})(\d{2})(\d{2})$/
            hora_formatada = "#{$1}:#{$2}:#{$3}"
          end

          data_hora_formatada = "#{data_formatada} #{hora_formatada}"

          Cnab.create!(tipo: tipo.to_i, data: data_hora_formatada, valor: valor.to_f, cpf: cpf, cartao: cartao, nome_proprietario: nome_dono, nome_loja: nome_loja)
        }
        head :created
      rescue => error
        puts "error: #{error}"
        head :internal_server_error
      end
    end

    private
    
    def insert(obj={})
 
      Cnab.new(
        tipo: obj.tipo, 
        data: obj.data,
        valor: obj.valor,
        cpf: obj.cpf,
        cartao: obj.cartao,
        hora: obj.hora,
        nome_proprietario: obj.nome_dono.strip,
        nome_loja: obj.nome_loja.strip,
      )
      
    end

    def authenticate
      begin
        token = request.headers['Authorization']
      
        decoded_token = JWT.decode(token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' })
        
        decoded_token.each { | x |
          if x['username']
            user = User.find_by(username: x['username'])
            session[:user_id] = user.id
          end
        }
      rescue
        head :unauthorized
      end
    end
  end
end
