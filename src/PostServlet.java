
import java.io.IOException;
import java.io.PrintWriter;

import java.sql.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/PostServlet")
public class PostServlet extends HttpServlet { //for posting topics and replies
	
	public String stripHtml(String s) //prevents HTML injection
	{
		String result = s.replaceAll("<","&lt;");
		result = result.replaceAll(">", "&gt;");
		return result;
	}
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
    	String title = req.getParameter("title");
    	String content = req.getParameter("content");
    	content = stripHtml(content);
    	String forum = req.getParameter("forum");
    	HttpSession session = req.getSession(true);
    	String userName = (String) session.getAttribute("USERNAME");
    	
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
    	PreparedStatement stm1 = null;   
    	PreparedStatement stm2 = null;
    	String topicId = req.getParameter("topic");
    	if(topicId==null)//new topic
    	{
	    	try {
	    		con.setAutoCommit(false);
	    		String insert1 = "INSERT INTO ANDREUR_TOPICS(TITLE,USERNAME,CREATED,FORUM) VALUES(?,?,?,?)";
	    		String insert2 = "INSERT INTO ANDREUR_POSTS(CONTENT,USERNAME,TOPIC_ID,CREATED) VALUES(?,?,ANDREUR_TOPIC_SEQ.currval,?)";
	    		stm1 = con.prepareStatement(insert1);
	    		stm2 = con.prepareStatement(insert2);
	    		stm1.setString(1, title);
	    		stm1.setString(2, userName);
	    		stm1.setTimestamp(3,new java.sql.Timestamp(new java.util.Date().getTime()));
	    		stm1.setString(4,forum);
	    		stm1.executeUpdate();
	    		stm2.setString(1, content);
	    		stm2.setString(2, userName);
	    		stm2.setTimestamp(3,new java.sql.Timestamp(new java.util.Date().getTime()));
	    		stm2.executeUpdate();
	    		con.commit();
	    		out.println("<div class=\"item\"><h1>New topic has been created!</h1>" +
	        			"Click <a href=\"forumdisplay.jsp?f="+forum+"\">here</a> to return to the forum."+
	        			"</div>");
	      	  if (stm1 != null) stm1.close();
	      	  if (stm2 != null) stm2.close();
	    		
			} catch (SQLException e) {
				try {
					con.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				out.println("<div class=\"item\"><h1>Post Response </h1>" +
	        			"Something has gone wrong!"+
	        			"</div>");
				e.printStackTrace();
			}
    	}
    	else //new reply
    	{
    		try {
    			con.setAutoCommit(false);
    			String insert1 = "INSERT INTO ANDREUR_POSTS(CONTENT,USERNAME,TOPIC_ID,CREATED) VALUES(?,?,?,?)";
    			String update1 = "UPDATE ANDREUR_TOPICS SET CREATED = ? WHERE ID = ?";
    			stm1 = con.prepareStatement(insert1);
				stm1.setString(1, content);
				stm1.setString(2, userName);
	    		stm1.setInt(3, Integer.parseInt(topicId));
	    		stm1.setTimestamp(4,new java.sql.Timestamp(new java.util.Date().getTime()));
	    		stm1.executeUpdate();
	    		stm2 = con.prepareStatement(update1);
	    		stm2.setTimestamp(1,new java.sql.Timestamp(new java.util.Date().getTime()));
	    		stm2.setInt(2, Integer.parseInt(topicId));
	    		stm2.executeUpdate();
	    		con.commit();
	    		String select = "SELECT TITLE FROM ANDREUR_TOPICS WHERE ID='"+topicId+"'";
	    		PreparedStatement stm3 = con.prepareStatement(select);
	    		ResultSet rs = stm3.executeQuery();
	    		rs.next();
	    		out.println("<div class=\"item\"><h1>Your reply has been posted!</h1>" +
	        			"Click <a href=\"topicdisplay.jsp?t="+topicId+"\">here</a> to return to the forum."+
	        			"</div>");
	    		if (rs != null) rs.close();
	    		if (stm1 != null) stm1.close();
		      	 if (stm2 != null) stm2.close();
			} catch (SQLException e) {
				try {
					con.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				out.println("<div class=\"item\"><h1>Post Response </h1>" +
	        			"Something has gone wrong!"+
	        			"</div>");
				e.printStackTrace();
			}
    		
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
