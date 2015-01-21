<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.TwelvePubs.View" %>

<script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBEe6WohIsZUFdQQHybOdgrqgwvf9Ifmu4">
    </script>

<style type="text/css">
      html, body, #map-canvas { height: 100%; margin: 0; padding: 0;}
      #map-canvas { height: 200px;width:200px; margin: 0; padding: 0;}
    </style>

<div class="row">
    <div class="col-xs-6">
        <div class="eventList"></div>
    </div>
    <div class="col-xs-6">
        <div id="addEvent" class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Event Name:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventName" type="text" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Event Date:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventDate" type="date" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Event Start Time:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventStartTime" type="time" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Event End Time:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventEndTime" type="time" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Town/City:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventCity" type="text" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Latitude:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventLatitude" type="text" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Longitude:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventLongitude" type="text" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-4 control-label"><span>Organiser Name:</span></label>
                <div class="col-sm-8">
                    <input class="form-control" id="eventOrganiser" type="text" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-2">
                    <a id="AddEvent" title="AddEvent" class="btn btn-default">Add Event</a>
                </div>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript">
    //Start Load Events
    function loadEvents() {
        $.getJSON(
            "/DesktopModules/TwelvePubs/API/TwelvePubsEvent/GetEvents",
           function (result) {
               $('.eventList').html("");
               var parsedTaskJSONObject = jQuery.parseJSON(result);
               $.each(parsedTaskJSONObject, function () {
                   $('.eventList').append(
                       '<div class="event">' +
                                           this.Name + '<br />' +
                                           this.City + '<br />' +
                                           '<a id="#EventDetailLink" class="btn btn-default" href="?EventID='+this.EventID +'">View Event Details</a><hr></div>'
                                          );
               })
             
           });
    }
    loadEvents();
    //End Load Events

    //Start Add Event
    $('#AddEvent').click(function () {
        var eventName = $('#eventName').val();
        var eventDate = $('#eventDate').val();
        var eventStartTime = $('#eventStartTime').val();
        var eventEndTime = $('#eventEndTime').val();
        var eventCity = $('#eventCity').val();
        var eventLatitude = $('#eventLatitude').val();
        var eventLongitude = $('#eventLongitude').val();
        var eventOrganiser = $('#eventOrganiser').val();

        var EventToCreate = {
            ETC_Name: eventName,
            ETC_Date: eventDate,
            ETC_StartTime: eventStartTime,
            ETC_EndTime: eventEndTime,
            ETC_City: eventCity,
            ETC_Latitude: eventLatitude,
            ETC_Longitude: eventLongitude,
            ETC_Organiser: eventOrganiser
        };

        var sf = $.ServicesFramework(<%:ModuleContext.ModuleId%>);

        $.ajax({
            url: '/DesktopModules/TwelvePubs/API/TwelvePubsEvent/AddEvent',
            type: "POST",
            contentType: "application/json",
           beforeSend: sf.setModuleHeaders,
            data: JSON.stringify(EventToCreate),
            success: function (data) {
                loadEvents();
            }
        });

    });


    //End Add Event


    var vars = [], hash;
    var q = document.URL.split('?')[1];
    if (q != undefined) {
        q = q.split('&');
        for (var i = 0; i < q.length; i++) {
            hash = q[i].split('=');
            vars.push(hash[1]);
            vars[hash[0]] = hash[1];
        }
    }

    var EventID = vars['EventID'];
    if (EventID.length > 0) {
        //alert(EventID);

        //Start Load Event
        function loadEvent() {
            $.getJSON(
                "/DesktopModules/TwelvePubs/API/TwelvePubsEvent/GetEvent?EventID=" + EventID,
               function (result) {
                 
                   $('.eventList').html("");
                   var parsedTaskJSONObject = jQuery.parseJSON(result);
                   
                   $.each(parsedTaskJSONObject, function () {
                       var longitude = this.longitude;
                       var latitude = this.latitude;
                       $('.eventList').append(
                           '<div class="eventdetails">' +
                                               this.Name + '<br />' +
                                               this.City + '<br />' +
                                               this.Latitude + '<br />' +
                                               this.Longitude +
                                               '<div id="map-canvas"></div>'
                                               
                        );
                       function initialize() {
                           var mapOptions = {
                               center: { lat: this.latitude, lng: this.longitude },
                               zoom: 8
                           };
                           var map = new google.maps.Map(document.getElementById('map-canvas'),
                               mapOptions);
                       }
                       google.maps.event.addDomListener(window, 'load', initialize);

                      // document.title = 'Pub Crawl in ' + this.City +' | Twelve Pubs of Richmond';
                   })

               });
        }
        loadEvent();
        //End Load Event


    } else {

    }





</script>
