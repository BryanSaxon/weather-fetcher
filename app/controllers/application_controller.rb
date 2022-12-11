class ApplicationController < ActionController::Base
  after_action :discard_flash

  private

  def discard_flash
    flash.discard if request.xhr?
  end
end
