class PagesController < ApplicationController
  def home
    @microsite = Microsite.new
    @microsites = Microsite.all
    @hash = Gmaps4rails.build_markers(@microsites) do |microsite, marker|
      marker.lat microsite.field_lat
      marker.lng microsite.field_lon
      marker.infowindow myinfowindow(microsite.site, microsite.field_lat, microsite.field_lon, microsite.location)
    end

    @search = Search.new(:microsite, params[:search], per_page: 5)
    @search.order = 'microsite_id'
    @search_data = @search.run

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @search_data }
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
