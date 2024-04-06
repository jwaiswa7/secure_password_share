class SecretsController < ApplicationController
  before_action :set_secret, only: [:show]
  def new
    @secret = Secret.new
  end

  def create
    @secret = Secret.new(secret_params)
    if @secret.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('secret', partial: 'secrets/secret', locals: { secret: @secret })
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('errors', partial: 'shared/errors',
                                                              locals: { errors: @secret.errors })
        end
      end
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
