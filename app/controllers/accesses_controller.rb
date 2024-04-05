class AccessesController < ApplicationController
  def def(_new)
    @access = Access.new
  end

  def create; end

  private

  def access_params
    params.require(:access).permit(:password)
  end
end
