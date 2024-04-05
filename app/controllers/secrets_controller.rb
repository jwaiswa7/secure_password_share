class SecretsController < ApplicationController
  before_action :set_secret, only: [:show]
  def new
    @secret = Secret.new
  end

  def create
    @secret = Secret.new(secret_params)
    if @secret.save
      redirect_to root_path, notice: 'Secret was successfully created.'
    else
      render :new
    end
  end

  private

  def set_secret
    @secret = Secret.find(params[:id])
    raise ActiveRecord::RecordNotFound if @secret.is_accessed
  end

  def secret_params
    params.require(:secret).permit(:information, :life_time, :password, :password_confirmation)
  end
end
