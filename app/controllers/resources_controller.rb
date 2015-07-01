class ResourcesController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def create
    qiniu_path = URI.parse(params[:qiniu_url]).path
    @resource = Resource.create(
      user:       current_user,
      kind:       params[:kind],
      qiniu_path: qiniu_path
    )
    render :json => @resource
  end
end
