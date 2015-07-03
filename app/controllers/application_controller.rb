class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_uv_id
    uv_id = cookies.signed[:uv_id]
    if uv_id.blank?
      uv_id = randstr
      cookies.permanent.signed[:uv_id] = uv_id
    end
    uv_id
  end
end
