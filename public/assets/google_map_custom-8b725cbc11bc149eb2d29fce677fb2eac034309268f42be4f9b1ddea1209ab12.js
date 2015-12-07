window.onload = function () {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {

      },
      internal: {
          id: 'map'
      }
  }, function(){
    markers = handler.addMarkers($('#map').data('microsites'));
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
}
