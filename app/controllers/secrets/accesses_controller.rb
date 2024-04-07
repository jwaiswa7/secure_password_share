module Secret
  class AccessesController < ApplicationController
    before_action :set_secret
  
    def new; end
  
    def create
      information = @secret.decrypt_information(password: access_params[:password])
      if information
        puts information
        redirect_to root_path, notice: 'Secret was successfully decrypted.'
      else
        render :new
      end
    end
  
    private
  
    def set_secret
      @secret = Secret.find(params[:secret_id])
    end
  
    def access_params
      params.permit(:password)
    end
  end
end
