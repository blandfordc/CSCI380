package servlet;

import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;

import DataAccess.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;





	     public class loginServlet extends HttpServlet{
		 public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		    PrintWriter out = response.getWriter();
		    try{
			DataAccess.establishConnection();
		    }
		    catch(Exception e){System.out.println(e);}
		    String name = request.getParameter("Name");
		    String password = request.getParameter("Password");
		    Map<String, Object> agency = DataAccess.getItemByPrimaryKey("organizations", name);
		    System.out.println(agency);
		    String actualPassword = (String) agency.get("password");
		    System.out.println(actualPassword);
		    if(password == actualPassword) {
			try{
			    out.println("<!DOCTYPE html>");
			    out.println("<html><head>");
			    out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
			    out.println("<title>Login Successfull!</title></head>");
			    out.println("<style> body{ text-shadow: 1px 1px 1px black!important; background-image: url('gradient.jpeg');} ul.menu{ list-style-type: square; margin:0; padding:0; width: 15%; position:fixed; height: 100%; overflow: auto;} h1{ text-align:center; font-variant:small-caps; color: #ffffff} li a{text-align:center; display: block; background-color: #43BBAA; color:white; padding: 10px 1px; border-radius: 25px;} li a.active{ background-color:#3FAA68;color:white;} li a:hover:not(.active){ background-color: #99BBB6;color:white;} div{ margin-left:16%;padding: 1px 16px;height:1000px;color:white;}table {border-radius: 10px; font-family: arial, sans-serif;border-collapse: collapse;width: 30%; color: #000000}td, th {text-align: center;padding: 8px;color: #ffffff}tr {color: #ffffff; text-align: right; background-color: #43BBAA;}tr:nth-child(even){background-color: #3FAA68;}</style>");
			    out.println("<body>");
			    out.println("<ul class='menu'><li>  <a class='active' href= '#home'><b>Home</b></a>                  </li><br><li>  <a href='programs.jsp'><b>Programs</b></a>                      </li><br><li>  <a href='houses.jsp'><b>Halfway Houses</b></a>                  </li><br><li>  <a href='resources.jsp'><b>Other Resources</b></a>              </li><br><li>  <a href='aboutUs.jsp'><b>About Us</b></a>                       </li></ul><h1>Successfully created agency!</h1>");
			    out.println("<h2 text-align:center;color:#ffffff;>now what?<h2>");
			    out.println("<table align='center'>");
			    out.println("</table><br>");
			    out.println("</body>");
			    out.println("</html>");
			

		    }finally{
			out.close();
		    }


		    }
		    else{try{out.println("wrong");}
			finally{out.close(); }}
		   


		 } 


	    }
	   
