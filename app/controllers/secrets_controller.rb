class SecretsController < ApplicationController

  def new
    @secret = Secret.new
  end
end
