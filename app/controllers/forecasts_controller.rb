class ForecastsController < ApplicationController
  def show
    current_cache = Forecast.find(params[:id])
    new_cache = ForecastCache.store(params[:id]) if current_cache.nil?

    if current_cache.present?
      flash[:notice] = "Forecast for #{params[:id]} was previously cached!"

      @forecast = current_cache
    elsif new_cache.present?
      @forecast = new_cache
    else
      flash[:notice] = "No location found for '#{params[:id]}'"

      render :index
    end
  end
end
