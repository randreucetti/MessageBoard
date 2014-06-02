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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {//for registering accounts
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	con = null;
    	try {
			con = DriverManager.getConnection("jdbc:oracle:thin:@136.206.35.131:1521:SSD", "ee_user", "ee_pass");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	res.setContentType("text/html");
        PrintWriter out = res.getWriter();
    	String username = req.getParameter("username");
    	String password = req.getParameter("password");
    	String question = req.getParameter("question");
    	String answer = req.getParameter("answer");
    	
    	
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
			// TODO Auto-generated catch block
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
    	try {
    		String insertStm = "INSERT INTO ANDREUR_USERS (USERNAME, PASSWORD,QUESTION,ANSWER) VALUES(?,?,?,?)";
			stm = con.prepareStatement(insertStm);
			stm.setString(1,username);
			stm.setString(2,sb.toString());
			stm.setString(3,question);
			stm.setString(4, answer);
			stm.executeUpdate();
			out.println("<div class=\"item\"><h1>Registration was successful: </h1>" +
	    			"Welcome to Sports YEAH!"+
	    			"Click <a href=\"index.jsp\">here</a> to go back to the homepage."+
	    			"</div>");
    		if (stm != null) stm.close();
		} catch (SQLException e) {
			out.println("<div class=\"item\"><h1>Registration has failed: </h1>" +
	    			"Please try a differient username <br />"+
	    			"Click <a href=\"register.jsp\">here</a> to go back to the registration page."+
	    			"</div>");
			e.printStackTrace();
		}
    	
    	}
    	else
    	{
    		out.println("<div class=\"item\"><h1>Error creating user account</h1>" +
        			"Please ensure valid input:<ul>"+
    				"<li>Usernames can contain only letters and numbers.</li>" + 
    				"<li>Passwords can contain only letters and numbers.</li>" + 
    				"<li>Answer to question must not be null</li></ul>" + 
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
