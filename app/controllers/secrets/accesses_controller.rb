module Secrets
  class AccessesController < ApplicationController
    before_action :set_secret

    def new; end

    def create
      information = @secret.decrypt_information!(password: access_params[:password])
      respond_to do |format|
        format.turbo_stream do
          if @secret.errors.present?
            render turbo_stream: turbo_stream.replace('secret', partial: 'shared/errors',
                                                                locals: { errors: @secret.errors })
          else
            @secret.destroy
            render turbo_stream: turbo_stream.replace('secret', partial: 'secrets/information',
                                                                locals: { information: })
          end
        end
      end
    end

    private

    def set_secret
      @secret = Secret.find(params[:secret_id])
    rescue ActiveRecord::RecordNotFound
      @secret = nil
    end

    def access_params
      params.permit(:password)
    end
  end
end
