class MicrositesController < ApplicationController
  def new
    @microsite = Microsite.new
  end

  def create
    @microsite = Microsite.new(microsite_params)
    @microsite.save
    redirect_to root_path, :flash => { :error => @microsite.errors.full_messages.join(', ') }
  end

  private

  def microsite_params
    params.require(:microsite).permit(:site, :field_lat, :field_lon, :location, :country, :state_province, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height)
  end
end
