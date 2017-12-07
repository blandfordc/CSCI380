<!DOCTYPE html>
<html>

   <head>

      <title>Heroin Home Page</title>
      <!-- link rel="stylesheet" href="" -->
      <style>
       #map {
        height: 100%;
      }
      body{
         text-shadow: 1px 1px 1px black!important; 
         background-image: url("gradient.jpeg");
      }

      ul.menu{
         list-style-type: square;
         margin:0;
         padding:0;
         width: 15%;
         position:fixed;
         height: 100%;
         overflow: auto;

      } 

      h1{
         text-align:center;
         font-variant:small-caps;
      }

      li a{
         text-align:center;
         display: block;
         background-color: #43BBAA;
         color:white;
         padding: 10px 1px;
         border-radius: 25px;
      }

      li a.active{
         background-color:#3FAA68;
         color:white;
      }

      li a:hover:not(.active){
         background-color: #99BBB6;
         color:white;
      }

      div{
         margin-left:16%;
         padding: 1px 16px;
         height:1000px;
         color:white;
      }

      </style>

   </head>

   <body>
     <div id="map" align="center"></div>
    <script>
     var origin = '3800 Victory Pkwy, Cincinnati, OH 45207';
     var destination = '5716 Kroegermount drive';

     var service = new google.maps.DistanceMatrixService();
     service.getDistanceMatrix(
     {
     origins: [origin],
     destinations: [destination],
     travelMode: 'DRIVING',
     transitOptions: TransitOptions,
     drivingOptions: DrivingOptions,
     unitSystem: UnitSystem,
     avoidHighways: Boolean,
     avoidTolls: Boolean,
     }, callback);

     function callback(response, status) {
     if (status == 'OK') {
     var origins = response.originAddresses;
    var destinations = response.destinationAddresses;

    for (var i = 0; i < origins.length; i++) {
      var results = response.rows[i].elements;
      for (var j = 0; j < results.length; j++) {
        var element = results[j];
        var distance = element.distance.text;
        var duration = element.duration.text;
        var from = origins[i];
        var to = destinations[j];
      }
    }
}
}

    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCu-onDKmlppLPe-8OZIiuoGAO0alno5dg&callback=callback">
    </script>
      <ul class="menu">
         <li>  <a class="active" href= "#home"><b>Home</b></a>                  </li>
         <br>
         <li>  <a href="programs.jsp"><b>Programs</b></a>                      </li>
         <br>
         <li>  <a href="houses.jsp"><b>Halfway Houses</b></a>                  </li>
         <br>
         <li>  <a href="resources.jsp"><b>Other Resources</b></a>              </li>
         <br>
         <li>  <a href="aboutUs.jsp"><b>About Us</b></a>                       </li>
	 <br>
	 <li> <a href="login.jsp"><b>Login</b></a>                                </li>
	 <br>
	 <li> <a href="createAnOrganization.jsp"><b>New Agency</b></a>                                </li>
      </ul>

      <div class ="welcome">
         <b>
            <h1> Home Page For Our Project </h1>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>
            <p> text n stuff here.... </p>

         </b>
      </div>



   </body>

</html>
