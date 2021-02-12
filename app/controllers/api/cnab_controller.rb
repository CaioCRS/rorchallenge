module Api
  class CnabController < ApplicationController
    before_action :authenticate

    def index
      render json: { teste: 'Teste' }
    end

    def create
      file = Base64.decode64(params[:file])

      lines = file.split(/\n+|\r+/).reject(&:empty?)

      lines.each_with_index do |x, _i|
        tipo = x[0]
        data = x[1..8]
        valor = x[9..18]
        cpf = x[19..29]
        cartao = x[30..41]
        hora = x[42..47]
        nome_dono = x[48..61]
        nome_loja = x[62..80]

        if data =~ /^(\d{4})(\d{2})(\d{2})$/
          data_formatada = "#{Regexp.last_match(1)}-#{Regexp.last_match(2)}-#{Regexp.last_match(3)}"
        end

        if hora =~ /^(\d{2})(\d{2})(\d{2})$/
          hora_formatada = "#{Regexp.last_match(1)}:#{Regexp.last_match(2)}:#{Regexp.last_match(3)}"
        end

        data_hora_formatada = "#{data_formatada} #{hora_formatada}"

        Cnab.create!(tipo: tipo.to_i, data: data_hora_formatada, valor: valor.to_f, cpf: cpf, cartao: cartao,
                     nome_proprietario: nome_dono, nome_loja: nome_loja)
      end
      head :created
    rescue StandardError => e
      puts "error: #{e}"
      head :internal_server_error
    end

    private

    def insert(obj = {})
      Cnab.new(
        tipo: obj.tipo,
        data: obj.data,
        valor: obj.valor,
        cpf: obj.cpf,
        cartao: obj.cartao,
        hora: obj.hora,
        nome_proprietario: obj.nome_dono.strip,
        nome_loja: obj.nome_loja.strip
      )
    end

    def authenticate
      token = request.headers['Authorization']

      decoded_token = JWT.decode(token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' })

      decoded_token.each do |x|
        if x['username']
          user = User.find_by(username: x['username'])
          session[:user_id] = user.id
        end
      end
    rescue StandardError
      head :unauthorized
    end
  end
end
