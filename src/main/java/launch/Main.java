package launch;

import java.io.File;
import DataAccess.*;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.apache.catalina.connector.Connector;
import org.apache.catalina.Service;
import org.apache.catalina.Context;


public class Main {

    public static void main(String[] args) throws Exception {
        String webappDirLocation = "src/main/webapp/";
        Tomcat tomcat = new Tomcat();
        //tomcat.getService().addConnector(getSslConnector());
        try{
	    DataAccess.establishConnection();
	    DataAccess.LoadData();
	}
	catch (Exception e){}
        //The port that we should run on can be set into an environment variable
        //Look for that variable and default to 8080 if it isn't there.
	
        String webPort = System.getenv("PORT");
        if(webPort == null || webPort.isEmpty()) {
            webPort = "8080";
        }


        StandardContext ctx = (StandardContext) tomcat.addWebapp("/", new File(webappDirLocation).getAbsolutePath());
        System.out.println("configuring app with basedir: " + new File("./" + webappDirLocation).getAbsolutePath());

        // Declare an alternative location for your "WEB-INF/classes" dir
        // Servlet 3.0 annotation will work
        File additionWebInfClasses = new File("target/classes");
        WebResourceRoot resources = new StandardRoot(ctx);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
        ctx.setResources(resources);
	tomcat.start();
	tomcat.getServer().await();
        
    }

    private static Connector getSslConnector() {
	Connector connector = new Connector();
	connector.setPort(8080);
	connector.setSecure(true);
	connector.setScheme("https");
	connector.setAttribute("keyAlias", "tomcat");
	connector.setAttribute("keystorePass", "password");
	connector.setAttribute("keystoreType", "JKS");
	connector.setAttribute("keystoreFile", "keystore.jks");
	connector.setAttribute("clientAuth", "false");
	connector.setAttribute("protocol", "HTTP/1.1");
	connector.setAttribute("sslProtocol", "TLS");
	connector.setAttribute("maxThreads", "200");
	connector.setAttribute("protocol", "org.apache.coyote.http11.Http11AprProtocol");
	connector.setAttribute("SSLEnabled", true);
	return connector;
    }
}
