

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */


	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
        PrintWriter out = res.getWriter();
    	HttpSession session = req.getSession(true);
    	
    	out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n" +
    			"<html>\n" +
    			"<head>\n" +
    			"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
    			"<link rel=\"stylesheet\" type=\"text/css\" href=\"CSS/theme.css\" />\n" +
    			"<title>My Message Board</title>\n" +
    			"</head>\n" +
    			"<body>\n"
    			                + "<div class=\"header\">\n" +
    			"	<div class=\"middle\">\n" +
    			"		<div class=\"logo\"><a href=\"index.jsp\"><img src=\"images/logo.png\"></a></div>\n" +
    			"	</div>\n" +
    			"</div>\n" +
    			"<div class =\"content\">\n" +
    			"	<div class=\"middle\">");	//header stuff again
    	
    		session.setAttribute("USERNAME", null);	//logs out for session
    		session.setAttribute("loggedIn", false);
    		out.println("<div class=\"item\"><h1>Login Response </h1>" +
        			"You have been logged out! <br />"+
        			"Click <a href=\"index.jsp\">here</a> to go back to the homepage."+
        			"</div>");
    	
    	
    		out.println("</div>\n" +
        			"</div>\n" +
        			"<div class =\"footer\">\n" +
        			"	<div class=\"middle\">\n" +
        			"			<a href=\"faq.jsp\">FAQ</a> --- <a href=\"charter.jsp\">Charter</a> --- <a href=\"about.jsp\">About</a> \n" +
        			"	</div>\n" +
        			"</div>" +
        			"</body>\n" +
        			"</html>");
    	
    	out.close();
	}

}
