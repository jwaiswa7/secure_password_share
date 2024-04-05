class SecretsController < ApplicationController

  def new
    @secret = Secret.new
  end

  def create
    @secret = Secret.new(secret_params)
    if @secret.save
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def secret_params
    params.require(:secret).permit(:information, :life_time, :password, :password_confirmation)
  end
end
