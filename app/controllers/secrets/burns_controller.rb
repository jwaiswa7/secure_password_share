module Secrets
  class BurnsController < ApplicationController
    before_action :set_secret
    
    def new
    end

    def create
      @burn = Burn.new(burn_params)
      if @burn.save
        redirect_to root_path, notice: 'Burned!'
      else
        render :new
      end
    end

    private

    def set_secret
      @secret = Secret.find(params[:secret_id])
    end

    def burn_params
      params.require(:burn).permit(:secret_id)
    end
  end
end