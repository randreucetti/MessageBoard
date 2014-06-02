//Encryption code borrowed from: http://www.avajava.com/tutorials/lessons/how-do-i-generate-an-md5-digest-for-a-string.html

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private static Connection con;
    
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
    	try {
			Class.forName("oracle.jdbc.driver.OracleDriver");	//loads db driver
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    	con = null;
    	try {
			con = DriverManager.getConnection("jdbc:oracle:thin:@136.206.35.131:1521:SSD", "ee_user", "ee_pass");	//connects
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	res.setContentType("text/html");
        PrintWriter out = res.getWriter();
    	String username = req.getParameter("username");
    	String password = req.getParameter("password");
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
    			"	<div class=\"middle\">");	//this just loads the header via html
    	MessageDigest md = null;	//following lines of code to encrypt passwords with MD5
    	try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
    	md.update(password.getBytes());	//borrowed code, see reference
    	byte[] digest = md.digest();
    	StringBuffer sb = new StringBuffer();
    	for(byte b:digest)
    	{
    		sb.append(Integer.toHexString((int)(b & 0xff)));    				
    	}    	
    	PreparedStatement stm = null;    	
    	ResultSet rs;
			
    	try {
    		String selectStm = "SELECT USERNAME FROM ANDREUR_USERS WHERE USERNAME = ? AND PASSWORD = ?";
    		stm = con.prepareStatement(selectStm);
    		stm.setString(1, username);	//looks for user that matches
    		stm.setString(2, sb.toString());
			rs = stm.executeQuery();
			if(rs.next())	//it one is found
	    	{
	    		session.setAttribute("USERNAME", username); //logs in for the session
	    		session.setAttribute("loggedIn", true);
	    	}
			else
			{
				session.setAttribute("loggedIn", false);	//denied
			}	
			if (rs != null) rs.close();	//closes db stuff
	    	 if (stm != null) stm.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
    	if(loggedIn)	//success!
    	{
    		out.println("<div class=\"item\"><h1>Login Response </h1>" +
        			"The user is now logged in <br />"+
        			"Click <a href=\"index.jsp\">here</a> to go back to the homepage."+
    				"</div>");
    	}
    	else //failure :(
    	{
    		out.println("<div class=\"item\"><h1>Login Response </h1>" +
        			"Something has gone wrong! <br />"+
        			"Click <a href=\"login.jsp\">here</a> to go back to the login page."+
        			"</div>");
    	}
    	
    	
    	out.println("</div>\n" +
    			"</div>\n" +
    			"<div class =\"footer\">\n" +
    			"	<div class=\"middle\">\n" +
    			"			<a href=\"faq.jsp\">FAQ</a> --- <a href=\"charter.jsp\">Charter</a> --- <a href=\"about.jsp\">About</a> \n" +
    			"	</div>\n" +
    			"</div>" +
    			"</body>\n" +
    			"</html>");
    	 if (con != null)
 			try {
 				con.close();	//close the connection
 			} catch (SQLException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
    	out.close();
    }

}
