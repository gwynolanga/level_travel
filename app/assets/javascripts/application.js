//= require rails-ujs
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

$(document).on('turbolinks:load', function() {
  if (gon.buildings.length !== 0) {
    let map = L.map('mapid', { attributionControl: false}).setView([gon.random_building.latitude, gon.random_building.longitude], 16);

    // leaflet-plugin aka Yandex map tileLayer
    // Yandex maps do not work correctly on Mozilla Firefox, use Google Chrome:
    // https://github.com/shramov/leaflet-plugins/issues/293
    // https://github.com/shramov/leaflet-plugins/issues/294
    //
    // Comment the lines of code if you do not want to use Yandex maps
    let yandexLayer = new L.yandex();
    map.addLayer(yandexLayer);

    // Uncomment the lines of code for using the alternative tileLayer
    // tileLayer works in any browser
    // L.tileLayer('https://maps.heigit.org/openmapsurfer/tiles/roads/webmercator/{z}/{x}/{y}.png', {
    //   maxZoom: 18,
    // }).addTo(map);

    $.each(gon.buildings, function(index, object) {
      let address = `${object.address}`;

      L.marker([object.latitude, object.longitude]).addTo(map)
        .bindPopup(`<b>${object.name}</b><br />${address}`);
    });

    var popup = L.popup();

    function onMapClick(e) {
      popup
        .setLatLng(e.latlng)
        .setContent("Вы щёлкнули на карту в точке " + e.latlng.toString())
        .openOn(map);

      $.ajax({
        url: gon.root_url,
        method: "get",
        dataType: "script",
        data: { latitude: e.latlng["lat"], longitude: e.latlng["lng"] }
      });
    }

    map.on('click', onMapClick);
  }
});