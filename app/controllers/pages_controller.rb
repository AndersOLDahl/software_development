class PagesController < ApplicationController
  def home
    @microsite = Microsite.new
    @microsites = Microsite.all
    @sites = Microsite.all.collect{|m| m.site}.uniq.sort
    @country = Microsite.all.collect{|m| m.country}.uniq.sort
    @state_province = Microsite.all.collect{|m| m.state_province}.uniq.sort
    @zone = Microsite.all.collect{|m| m.zone}.uniq.sort
    @sub_zone = Microsite.all.collect{|m| m.sub_zone}.uniq.sort
    @biomimic = Microsite.all.collect{|m| m.biomimic}.uniq.sort
    @wave_exp = Microsite.all.collect{|m| m.wave_exp}.uniq.sort
    @hash = Gmaps4rails.build_markers(@microsites) do |microsite, marker|
      marker.lat microsite.field_lat
      marker.lng microsite.field_lon
      marker.infowindow myinfowindow(microsite.site, microsite.field_lat, microsite.field_lon, microsite.location)
    end

    @search = Search.new(:microsite, params[:search], per_page: 5)
    @search.order = 'microsite_id'
    @search_data = @search.run
  end

  def admin
    @microsite = Microsite.new
    @microsites = Microsite.all
    @sites = Microsite.all.collect{|m| m.site}.uniq.sort
    @country = Microsite.all.collect{|m| m.country}.uniq.sort
    @state_province = Microsite.all.collect{|m| m.state_province}.uniq.sort
    @zone = Microsite.all.collect{|m| m.zone}.uniq.sort
    @sub_zone = Microsite.all.collect{|m| m.sub_zone}.uniq.sort
    @biomimic = Microsite.all.collect{|m| m.biomimic}.uniq.sort
    @wave_exp = Microsite.all.collect{|m| m.wave_exp}.uniq.sort
  end

  def myinfowindow(site, lat, lng, location)
    "<div class=\"info-box\">
       <p class=\"info-box-text\"><b>Site:</b> #{site}</p>
       <p class=\"info-box-text\"><b>(Lat/Lon):</b> (#{lat}, #{lng})</p>
       <p class=\"info-box-text\"><b>Location:</b> #{location}</p>
     </div>"
  end
end
