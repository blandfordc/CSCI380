package servlet;


import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;

import DataAccess.*;
import launch.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.google.maps.DistanceMatrixApi;
import com.google.maps.GeoApiContext;
import com.google.maps.DistanceMatrixApiRequest;
import com.google.maps.model.DistanceMatrix;
import com.google.maps.*;

@WebServlet(
	    name ="homePageServlet",
	    urlPatterns = {"/home"}
	    )

public class homePageServlet extends HttpServlet{

    public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws IOException, ServletException {
      // Set the response message's MIME type
      response.setContentType("text/html;charset=UTF-8");
      try{
	  DataAccess.establishConnection();
      }
      catch(Exception e){System.out.println(e);}
      List <Map<String, AttributeValue>> organizations = DataAccess.printAll("organizations");
      
      String API_KEY = "AIzaSyCu-onDKmlppLPe-8OZIiuoGAO0alno5dg";
      String location = "3800 Victory Pkwy, cincinnati, Oh, 45207";
      GeoApiContext context = new GeoApiContext().setApiKey(API_KEY);
      String[] distances = new String[organizations.size()];
      int m = 0;
      for(Map<String, AttributeValue> organization : organizations){
	  String destination = organization.get("location").getS();
	  try{
	      DistanceMatrixApiRequest req = new DistanceMatrixApiRequest(context);
	      DistanceMatrix trix = req.origins(location)
		  .destinations(destination)
		  .await();
	           System.out.println(trix.rows[0].elements[0].distance);
		   distances[m] = trix.rows[0].elements[0].distance.toString();
		   if(trix.rows[0].elements[0].distance == null){
		       distances[m] = "0";
		   }
		   organization.put("distance", new AttributeValue(distances[m]));
       
	  }
	  catch (Exception e) {
	      System.out.println(e.getMessage());
	  }
	  m++;
      }
      for(int q = 0; q<organizations.size(); q++){
	      System.out.println( distances[q]);
	  }
      // Allocate a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
      
      
      try {
         out.println("<!DOCTYPE html>");
         out.println("<html><head>");
         out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
	 out.println("<script async defer src='https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Victoria+BC&key=" + API_KEY + "'></script>");
         out.println("<title>Agencies available, from the database.</title></head>");
	 out.println("<style> body{ text-shadow: 1px 1px 1px black!important; background-color: #00FFFF;} ul.menu{ list-style-type: square; margin:0; padding:0; width: 15%; position:fixed; height: 100%; overflow: auto;} h1{ text-align:center; font-variant:small-caps; color: #ffffff} li a{text-align:center; display: block; background-color: #43BBAA; color:white; padding: 10px 1px; border-radius: 25px;} li a.active{ background-color:#3FAA68;color:white;} li a:hover:not(.active){ background-color: #99BBB6;color:white;} div{ margin-left:16%;padding: 1px 16px;height:1000px;color:white;}table {border-radius: 10px; font-family: arial, sans-serif;border-collapse: collapse;width: 30%; color: #000000}td, th {text-align: center;padding: 8px;color: #ffffff}tr {color: #ffffff; text-align: right; background-color: #43BBAA;}tr:nth-child(even){background-color: #3FAA68;}</style>");
	 out.println("<body>");
	 out.println("<ul class='menu'><li>  <a class='active' href= '#home'><b>Home</b></a>                  </li><br><li>  <a href='programs.jsp'><b>Programs</b></a>                      </li><br><li>  <a href='houses.jsp'><b>Halfway Houses</b></a>                  </li><br><li>  <a href='resources.jsp'><b>Other Resources</b></a>              </li><br><li>  <a href='aboutUs.jsp'><b>About Us</b></a>                       </li><br><li>  <a href='login.jsp'><b>Login</b></a>              </li><br><li>  <a href='createAnOrganization.jsp'><b>New Agency</b></a> </li> <br><li>  <a href='/delete'><b>delete an agency</b></a>                </li></ul><h1>Agencies available</h1>");
	 int j = 0;
	 for (Map<String, AttributeValue> organization : organizations) {
	     out.println("<table align='center'>");
	     out.println("<tr><td>" + organization.get("name").getS() + "</td></tr>");
	     out.println("<tr><td>" + organization.get("location").getS() + "</td></tr>");
	     out.println("<tr><td>" + organization.get("services").getSS() + "</td></tr>");
	     out.println("<tr><td> <a class='active' href='https://www.google.com/maps/place/" + organization.get("location").getS() + "'>Get Directions</a>");
	     out.println("<tr><td> distance: " + distances[j] + "</td></tr>");
	     out.println("</table><br>");
	     j++;
	 }
         out.println("</body>");
         out.println("</html>");
      } finally {
         out.close();  // Always close the output writer
      }
   }
		
}
