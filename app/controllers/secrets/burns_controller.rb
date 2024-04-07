module Secrets
  class BurnsController < ApplicationController
    before_action :set_secret

    def new; end

    def create
      if @secret.decrypt_information!(password: burn_params[:password])
        @secret.destroy
        redirect_to root_path, notice: 'Secret was successfully burned.'
      else
        render :new
      end
    end

    private

    def set_secret
      @secret = Secret.find(params[:secret_id])
    end

    def burn_params
      params.permit(:password)
    end
  end
end
