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

/**
 * Servlet implementation class PasswordServlet
 */
@WebServlet("/PasswordServlet")
public class PasswordServlet extends HttpServlet {	//this servlet updates passwords
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private static Connection con;
    
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
    	try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    	con = null;
    	try {
			con = DriverManager.getConnection("jdbc:oracle:thin:@136.206.35.131:1521:SSD", "ee_user", "ee_pass");
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	res.setContentType("text/html");
        PrintWriter out = res.getWriter();	//from our form
    	String username = req.getParameter("user");
    	String password = req.getParameter("password");
    	String answer = req.getParameter("answer");
    	String correctAnswer = null;
    	
    	
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
    			"	<div class=\"middle\">");
    	if(FormValidator.validateUsername(username)&&FormValidator.validatePassword(password)&&FormValidator.validateContent(answer))
    	{
	    	MessageDigest md = null;	//following lines of code to encrypt passwords with MD5
	    	try {
				md = MessageDigest.getInstance("MD5");
			} catch (NoSuchAlgorithmException e1) {
				e1.printStackTrace();
			}
	    	md.update(password.getBytes());
	    	byte[] digest = md.digest();
	    	StringBuffer sb = new StringBuffer();
	    	for(byte b:digest)
	    	{
	    		sb.append(Integer.toHexString((int)(b & 0xff)));    				
	    	}    	
	    	PreparedStatement stm = null;
	    	ResultSet rs = null;
	    	try {
	    		String selectStm = "SELECT ANSWER FROM ANDREUR_USERS WHERE USERNAME = ?";	
				stm = con.prepareStatement(selectStm);
				stm.setString(1, username);
				rs = stm.executeQuery();
				if(rs.next())
					correctAnswer = rs.getString("ANSWER");
			} catch (SQLException e1) {
				out.println("<div class=\"item\"><h1>Password update has failed: </h1>" +
		    			"Please try a differient username"+
		    			"Click <a href=\"index.jsp\">here</a> to go back to the home page."+
		    			"</div>");
				e1.printStackTrace();
			}
	    	
	    	if(answer.toLowerCase().equals(correctAnswer.toLowerCase())) //convert to lowercase and checks if match
	    	{
		    	try {
		    		String updateStm = "UPDATE ANDREUR_USERS SET PASSWORD = ? WHERE USERNAME = ?";
					stm = con.prepareStatement(updateStm);;
					stm.setString(1,sb.toString());
					stm.setString(2, username);
					stm.executeUpdate();	//updates the password
					out.println("<div class=\"item\"><h1>Password was updated successfully: </h1>" +
			    			"Welcome to Sports YEAH!"+
			    			"Click <a href=\"index.jsp\">here</a> to go back to the homepage."+
			    			"</div>");
					if (rs != null) rs.close();
			    	  if (stm != null) stm.close();
				} catch (SQLException e) {
					out.println("<div class=\"item\"><h1>Password update has failed: </h1>" +
			    			"Please try a differient username"+
			    			"Click <a href=\"index.jsp\">here</a> to go back to the home page."+
			    			"</div>");
					e.printStackTrace();
				}
	    	}
	    	else
	    	{
	    		out.println("<div class=\"item\"><h1>Error updating password</h1>" +
	        			"The security answer was not correct"+
	        			"</div>");
	    	}
	    	
	    	}
    	else
    	{
    		out.println("<div class=\"item\"><h1>Error updating password</h1>" +
        			"Please ensure valid input:<ul>"+
    				"<li>Passwords can contain only letters and numbers.</li></ul>" + 
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
    	
    	out.close();
    	 if (con != null)
 			try {
 				con.close();
 			} catch (SQLException e) {
 				// TODO Auto-generated catch block
 				e.printStackTrace();
 			}
    }

}
