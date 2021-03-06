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
      marker.infowindow myinfowindow(microsite.id, microsite.site, microsite.field_lat, microsite.field_lon, microsite.location, microsite.biomimic, microsite.wave_exp)
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

  def myinfowindow(id, site, lat, lon, location, biomimic, wave_exp)
    "<div class=\"info-box\">
       <p class=\"info-box-text\"><b>ID:</b> #{id}</p>
       <p class=\"info-box-text\"><b>Site:</b> #{site}</p>
       <p class=\"info-box-text\"><b>(Lat/Lon):</b> (#{lat}, #{lon})</p>
       <p class=\"info-box-text\"><b>Location:</b> #{location}</p>
       <p class=\"info-box-text\"><b>Biomimic:</b> #{biomimic}</p>
       <p class=\"info-box-text\"><b>Wave Exposure:</b> #{wave_exp}</p>
     </div>"
  end
end
