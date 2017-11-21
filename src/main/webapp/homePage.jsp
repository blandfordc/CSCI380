<!DOCTYPE html>
<html>

   <head>

      <title>Heroin Home Page</title>
      <!-- link rel="stylesheet" href="" -->
      <style>

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
