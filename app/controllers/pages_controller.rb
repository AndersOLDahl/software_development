class PagesController < ApplicationController
  def home
    @microsite = Microsite.new
    @microsites = Microsite.all
    @hash = Gmaps4rails.build_markers(@microsites) do |microsite, marker|
      marker.lat microsite.field_lat
      marker.lng microsite.field_lon
      marker.infowindow myinfowindow(microsite.site, microsite.field_lat, microsite.field_lon, microsite.location)
    end
  end
  def myinfowindow(site, lat, lng, location)
    "<div class=\"info-box\">
       <p class=\"info-box-text\"><b>Site:</b> #{site}</p>
       <p class=\"info-box-text\"><b>(Lat/Lon):</b> (#{lat}, #{lng})</p>
       <p class=\"info-box-text\"><b>Location:</b> #{location}</p>
     </div>"
  end
end
