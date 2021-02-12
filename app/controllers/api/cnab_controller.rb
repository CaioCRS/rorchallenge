module Api
  class CnabController < ApplicationController
    before_action :authenticate

    def index
      render json: {teste: 'Teste'}
    end

    private
    def authenticate
      token = request.headers['Authorization']
      decoded_token = JWT.decode(token, ENV['SECRET_KEY'], true, 'HS256')
      
      

    end


  end
end
