$(document).ready(function() {
    $("select").select2()
    $("#site").select2({ placeholder: "Select Sites"})
    $("#country").select2({ placeholder: "Select Countries"})
    $("#state_province").select2({ placeholder: "Select States/Provinces"})
    $("#zone").select2({ placeholder: "Select Zones"})
    $("#sub_zone").select2({ placeholder: "Select SubZones"})
    $("#biomimic").select2({ placeholder: "Select Biomimics"})
    $("#wave_exp").select2({ placeholder: "Select Wave Exposures"})
});
