<%@page session="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="manifest" href="/manifest.json">
    <link rel="stylesheet" href="css/jquery-ui.min.css">
    <!-- <link rel="stylesheet" href="css/jquery.typeahead.css"> -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- <script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script> -->
    <!-- <script src="js/jquery.typeahead.min.js"></script> -->
    <script src="js/jquery-ui.min.js"></script>
   	
	<script>
  if ('serviceWorker' in navigator) {
    console.log("Will the service worker register?");
    navigator.serviceWorker.register('service-worker.js')
      .then(function(reg){
        console.log("Yes, it did.");
      }).catch(function(err) {
        console.log("No it didn't. This happened: ", err)
      });
  }
</script>
    <script>
    var map;
    var markers = [];
        var myCenter=new google.maps.LatLng(45.434046,12.340284);

        function initialize()
        {
            var mapProp = {
              center:myCenter,
              zoom:1,
              mapTypeId:google.maps.MapTypeId.ROUTE
              };

            map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
            map.setTilt(0);
        }
        google.maps.event.addDomListener(window, 'load', initialize);
        
        $(function() {
            var availableTags = [];
              $( "#state" ).autocomplete({
                source: availableTags
              });
              $( "#city" ).autocomplete({
                source: availableTags
              });
              $( "#zip" ).autocomplete({
                source: availableTags
              });
          });

    </script>

</head>
<body>
<table class="table table-bordered">
    <td>
    <form action="">
        <div style="width: 100%; max-width: 800px;">
                <div class="input-group">
               <span>
                   <label class="control-label" style="text-align: left;">State: </label>
                   <input id="state" name="state" class="form-control" type="search" placeholder="State" autocomplete="on" onkeyup="stateKeyUp()">
               </span>
               <span class="input-group-btn" style="vertical-align: bottom;">
                   <button style="height:33px;" type="submit" class="btn btn-default" id="submitState">
                       <span class="glyphicon glyphicon-search"></span>
                   </button>
               </span> 
           </div>

           <div class="input-group">
               <span>
                   <label class="control-label" style="text-align: left;">City: </label>
                   <input id="city" name="city" class="form-control" type="search" placeholder="City" autocomplete="on" onkeyup="cityKeyUp()">
               </span>
               <span class="input-group-btn" style="vertical-align: bottom;">>
                   <button style="height:33px;" type="submit" class="btn btn-default" id="submitCity">
                       <span class="glyphicon glyphicon-search"></span>
                   </button>
               </span>
           </div>

           <div class="input-group">
               <span>
                   <label class="control-label" style="text-align: left;">ZipCode: </label>
                   <input id="zip" name="zip" class="form-control" type="search" placeholder="Zipcode" autocomplete="on" onkeyup="zipKeyUp()">
               </span>
               <span class="input-group-btn" style="vertical-align: bottom;">
                   <button  style="height:33px;" type="submit" class="btn btn-default" id="submitZip">
                       <span class="glyphicon glyphicon-search"></span>
                   </button>
               </span>
           </div>
</form>
            <script>

            var data = {states:[],city:[],zip:[]};
                $( "#submitState" ).on('click',function(event) {
                    event.preventDefault();
                    // alert("change state "+ $("#state").val());
                   if($("#state").val()) 
                    $.get('/maplookup/getStateCordinates/'+ $("#state").val(),function(zipCode){
                    	if(zipCode){
	                    	var newCenter = new google.maps.LatLng(zipCode.latitude, zipCode.longitude);
		                    map.setCenter(newCenter);
		                    map.setZoom(7);
		                    deleteMarkers();
	                    } else {
	               		 alert("Sorry!! STATE NOT FOUND");
               			}
                    });
                   
                    // alert("change "+ $("#state").val());
                   $.get('/maplookup/getCities/'+$("#state").val(),function(searchList){
               			 data.city =  searchList;
               			//console.log(data.city);
               		});
                })
                
                $( "#submitCity" ).on('click',function() {
                    event.preventDefault();
                    // alert("change state "+ $("#state").val());
                    // alert("change city "+ $("#city").val());
                    //post request here
                    	
                   if($("#state").val()){
                    $.get('/maplookup/getCityCordinates/'+$("#state").val()+'/'+$("#city").val(),function(zipCode){
                    	if(zipCode){
                    		    var newCenter = new google.maps.LatLng(zipCode.latitude, zipCode.longitude);
			                    map.setCenter(newCenter);
			                    map.setZoom(11);
			                    deleteMarkers();
			                 	$.get('/maplookup/getZips/'+$("#city").val()+'/'+$("#state").val(),function(searchList){
			                 		//console.log(searchList)
			                 		data.zip =  searchList;
			                	});
                    	}	
			       	 });
                   } else {
                	      $.get('/maplookup/getCityCordinate/'+$("#city").val(),function(states){
	                		   if(states){
		                			if(states.length == 1){
		                				$.get('/maplookup/getCityCordinates/'+states[0]+'/'+$("#city").val(),function(zipCode){
		                					if(zipCode){
		                            		    var newCenter = new google.maps.LatLng(zipCode.latitude, zipCode.longitude);
		        			                    map.setCenter(newCenter);
		        			                    map.setZoom(11);
		        			                    deleteMarkers();
		        			                 	$.get('/maplookup/getZips/'+$("#city").val()+'/'+$("#state").val(),function(searchList){
		        			                 		//console.log(searchList)
		        			                 		data.zip =  searchList;
		        			                	});
		                            		}	
		                				});
		                			} else {
		                				alert("Multiple state found:"+states);
		                				data.states=states;
		                			}
		                	  }
                		   });
                	   }
                	});
                
                $( "#submitZip" ).on('click',function() {
                    event.preventDefault();
                    $.get('/maplookup/getCordinates/'+$("#zip").val(),function(zipCode){
                    	//console.log(zipCode);
                    	if(zipCode){
                    		var newCenter = new google.maps.LatLng(zipCode.latitude, zipCode.longitude);
 		                    map.setCenter(newCenter);
 		                    map.setZoom(14);
 		                    addMarker(newCenter);                    		
                    	} else {
                    		alert("Sorry!! ZIPCODE NOT FOUND");
                    	}                    	
                    });
                })
				
               function stateKeyUp(){
                	if($("#city").val())
                		$('#state').autocomplete("option", { source: data.states });
                	else	
                	$.get('/maplookup/autocomplete/state/'+$("#state").val(),function(searchList){
                		$('#state').autocomplete("option", { source: searchList });
                	});
                }
                
                function cityKeyUp(){
	                if($("#state").val())	
	                		$('#city').autocomplete("option", { source: data.city });
	                else
	                	$.get('/maplookup/autocomplete/city/'+$("#city").val(),function(searchList){
	                		$('#city').autocomplete("option", { source: searchList });
	                	});
                }
                
                function zipKeyUp(){
                		if($("#city").val())
                			$('#zip').autocomplete("option", { source: data.zip });
	                	else
	                	
	                    	$.get('/maplookup/autocomplete/zip/'+$("#zip").val(),function(searchList){
	                    		$('#zip').autocomplete("option", { source: searchList });
	                    	});
	               }
                
			   function addMarker(location) {
                 var marker = new google.maps.Marker({
                   position: location,
                   map: map,
                   animation: google.maps.Animation.BOUNCE,
                 });
                 markers.push(marker);
               }

               // Deletes all markers in the array by removing references to them.
               function deleteMarkers() {
                 clearMarkers();
                 markers = [];
               }

               // Sets the map on all markers in the array.
               function setAllMap(map) {
                 for (var i = 0; i < markers.length; i++) {
                   markers[i].setMap(map);
                 }
               }

               // Removes the markers from the map, but keeps them in the array.
               function clearMarkers() {
                 setAllMap(null);
               }
            </script>
        </div>
    </td>
    <td>
        <td width="75%">
        <div id="googleMap" style="width:100%;height:500px;"></div>
    <td>
</table>

</body>
</html>