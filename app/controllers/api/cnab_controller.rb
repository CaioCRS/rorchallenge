module Api
  class CnabController < ApplicationController
    before_action :authenticate

    def index
      render json: {teste: 'Teste'}
    end

    private
    def authenticate
      begin
        token = request.headers['Authorization']
      
        decoded_token = JWT.decode(token, ENV['SECRET_KEY'], true, { algorithm: 'HS256' })
        
        decoded_token.each { | x, y |
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
