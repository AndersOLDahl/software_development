// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function updateFilter(options) {
//  for (var i = 0; i < options.selectedOptions.length; i++) {
//    console.log(options.selectedOptions[i].value);
//  }

    var form = document.getElementById("main-search");

    //Where they are in the form
    var site = form[2].value;
    var state_province = form[3].value;
    var zone = form[7].value;
    var country = form[5].selectedOptions;
    var biomimic = form[12].selectedOptions;
    var sub_zone = form[9].selectedOptions;
    var wave_exp = form[15].selectedOptions;

    console.log(site);
    console.log(state_province);
    console.log(country[0].value);
    
    console.log(zone);

    var build_url = "/readings.csv?"

    if(site.trim()) {
      build_url += "site="+site + "&";
    }
    if(state_province.trim()) {
      build_url += "state_province="+state_province + "&";
    }
    if(zone.trim()) {
      build_url += "zone="+zone + "&";
    }
    build_url += createMultiUrl("country", country);
    build_url += createMultiUrl("biomimic", biomimic);
    build_url += createMultiUrl("sub_zone", sub_zone);
    build_url += createMultiUrl("wave_exp", wave_exp);
    build_url = build_url.substring(0, build_url.length - 1);
    
    console.log(build_url);

    window.open(build_url);
}

function createMultiUrl(paramName, selectOption) {
    var parameter = "";
    if(selectOption.length == 0) {
      return "";
    }
    for (var i = 0; i < selectOption.length; i++) {
      parameter = parameter + paramName + "[]=" + selectOption[i].value + "&";
    }
    return parameter;
}
