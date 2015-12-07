class MicrositesController < ApplicationController
  def create
    if user_signed_in?
      @microsite = Microsite.new(microsite_params)
      @microsite.save
      redirect_to root_path, :flash => { :error => @microsite.errors.full_messages.join(', ') }
    end
  end

  def destroy
    if user_signed_in?
      @microsite = Microsite.find(params[:microsite][:id])
      @microsite.destroy
      redirect_to root_path
    end
  end

  private

  def microsite_params
    params.require(:microsite).permit(:site, :field_lat, :field_lon, :location, :country, :state_province, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height)
  end
end
