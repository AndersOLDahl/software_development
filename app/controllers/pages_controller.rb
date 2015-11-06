class PagesController < ApplicationController
  def home
    @microsites = Microsite.all
    @hash = Gmaps4rails.build_markers(@microsites) do |microsite, marker|
      marker.lat microsite.field_lat
      marker.lng microsite.field_lon
    end
  end
end
