class ProtozaurController < ApplicationController
  layout '../protozaur/layout/base'

  def index
    define_view(:floating)
  end

  def flex
    define_view(:holder)
  end

  def framework
    define_view(:font_family)
  end

  def inputs_buttons
    define_view(:inputs)
  end

  private

  def define_view(default_view)
    @view = params[:view] ? params[:view] : default_view
  end
end
