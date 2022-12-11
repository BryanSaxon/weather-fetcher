class PostalCodesController < ApplicationController
  def index
  end

  def create
    @postal_code = PostalCode.find_or_create(postal_code_params[:query])

    if @postal_code.present?
      redirect_to forecast_path(@postal_code.id)
    else
      redirect_to postal_codes_path,
        notice: "No location found for '#{postal_code_params[:query]}'"
    end
  end

  private

  def postal_code_params
    params.permit(:query)
  end
end
