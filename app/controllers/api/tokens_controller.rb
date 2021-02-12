module Api
  class TokensController < ApplicationController
    def create
      user = User.find_by(username: params[:username])

      if user.password_digest == params[:password]
        render json: {
          jwt: encoded_token({id: user.id, username: user.username})
        }
      else
        head :not_found
      end
    end

    private 
    def encoded_token(payload={})
      exp = 24.hours.from_now
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
    end

  end
end
