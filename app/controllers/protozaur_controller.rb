class ProtozaurController < ApplicationController
  layout '../protozaur/layout/base'

  def index
    @view = params[:view] ? params[:view] : :index
  end
end
