class TemplatesController < ApplicationController
  def index
    @templates = Template.page(params[:page])
  end

  def show
    @template = Template.find params[:id]
  end
end
