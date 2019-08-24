//= require rails-ujs
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

$(document).on('turbolinks:load', function() {
  setTimeout(function() {
    $(".alert").alert('close');
  }, 3000);

  let kill_item3 = function() {
    $('#item3').addClass('disabled').removeClass('active');
    $('#edit_building').removeClass('show active');
    
    if ($(this)[0].id === 'create_building') {
      $( ".has-error" ).remove();
    }
  };

  $('#item1').on('click', kill_item3);
  $('#item2').on('click', kill_item3);

  if (gon.buildings.length !== 0) {
    let map = L.map('mapid').setView([gon.random_building.latitude, gon.random_building.longitude], 14);

    L.tileLayer('https://maps.heigit.org/openmapsurfer/tiles/roads/webmercator/{z}/{x}/{y}.png', {
      maxZoom: 18,
    }).addTo(map);

    $.each(gon.buildings, function(index, object) {
      let address = `${object.address}`;

      L.marker([object.latitude, object.longitude]).addTo(map)
        .bindPopup(`<b>${object.name}</b><br />${address}`);
    });

    var popup = L.popup();

    function onMapClick(e) {
      popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
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