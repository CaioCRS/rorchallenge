module Api
  class CnabController < ApplicationController
    def index
      render json: {teste: 'Teste'}
    end
  end
end
