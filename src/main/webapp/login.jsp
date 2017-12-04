<!DOCTYPE html>
<html>

<head>
	<title>Services Login</title>
</head>

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
<script type="text/javascript">
    function checkvalue() { 
         var returnValue = true;
         var name = document.forms["Login"]["Name"].value;
         var password= document.forms["Login"]["Password"].value;
         if(name == "" || location == ""|| password == ""){
               alert("Empty Values not allowed!");    
               returnValue = false;
         }
         return returnValue;
    
    }
     </script>

<body>

	<ul class="menu">
		<li>  <a href="/home"><b>Home</b></a>                                     </li>
		<br>
		<li>  <a href="programs.jsp"><b>Programs</b></a>                                 </li>
		<br>
		<li>  <a href="houses.jsp"><b>Halfway Houses</b></a>                             </li>
		<br>
		<li>  <a href="resources.jsp"><b>Other Resources</b></a>                         </li>
		<br>
		<li>  <a href="aboutus.jsp"><b>About Us</b></a>				</li>
		<br>
		<li>  <a class="active" href="#login"><b>Login</b></a>                      </li>
	 </ul>

	<div class="container" id="login">
	  <h1>Login Page<h1>
	
       <form name="Login" action="login" onsubmit="return checkvalue()" method="GET">
	<table align='center'>
	  <tr>
	    <td>Agency Name</td>
	    <td><input type="text" name="Name"></td>
	  </tr>
	    <td>Password</td>
	    <td><input type="password" name="Password"></td>
	  </tr>
	  <tr align="center">
	    <td></td>
            <td><INPUT TYPE="submit" VALUE="Login"></td>
	  </tr>
	</table>
	
      </form>

</div>

</body>

</html>
