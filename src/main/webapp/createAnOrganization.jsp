<!DOCTYPE html>
<html>

   <head>

      <title>Enter new agency info</title>
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
      td{color: #ffffff}

      </style>

   </head>
   <script type="text/javascript">
    function checkvalue() { 
         var returnValue = true;
         var name = document.forms["createOrganization"]["Name"].value;
         var location = document.forms["createOrganization"]["Location"].value;
         var password= document.forms["createOrganization"]["Password"].value;
         if(name == "" || location == ""|| password == ""){
               alert("Empty Values not allowed!");    
               returnValue = false;
         }
         return returnValue;
    
    }
     </script>

   <body>
      <ul class="menu">
         <li>  <a href="/home"><b>Home</b></a>                                    </li>
         <br>
         <li>  <a href="programs.jsp"><b>Programs</b></a>                                </li>
         <br>
         <li>  <a href="houses.jsp"><b>Halfway Houses</b></a>                            </li>
         <br>
         <li>  <a href="resources.jsp"><b>Other Resources</b></a>                         </li>
         <br>
         <li>  <a class="active" href="#aboutUs"><b>About Us</b></a>                      </li>
	 <br>
         <li>  <a class="active" href="login.jsp"><b>Login</b></a>                      </li>
      </ul>
      <form name="createOrganization" action="createAgency" onsubmit="return checkvalue()" method="POST">
	<table align='center'>
	  <tr>
	    <td>Agency Name</td>
	    <td><input type="text" name="Name"></td>
	  </tr>
	  <tr>
	    <td>Agency Location</td>
	    <td><input type="text" name="Location"></td>
	  </tr>
	  <tr>
	    <td>Services available</td>
	    <td><input type="text" name="Services"></td><br>
	    <td><input type="text" name="Services"></td><br>
	    <td><input type="text" name="Services"></td><br>
	    <td><input type="text" name="Services"></td></tr>
	  <tr>
	    <td>Password</td>
	    <td><input type="password" name="Password"></td>
	  </tr>
	  <tr align="center">
	    <td></td>
            <td><INPUT TYPE="submit" VALUE="Create"></td>
	  </tr>
	</table>
	
      </form>
      <%
	 if(request.getParameter("Name") == null || request.getParameter("Location") == null || request.getParameter("Password") == null || request.getParameter("Services") == null){



	 %>
      <label></label>
      <% } %>

   </body>

</html>
