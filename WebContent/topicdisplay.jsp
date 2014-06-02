<!-- displays a specified topic -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Displaying Topic</title>
</head>
<body>
 <%@ include file="include/header.jsp" %>
 <% PreparedStatement stm;
    ResultSet rs;
    String title=null;
    stm = con.prepareStatement("SELECT TITLE FROM ANDREUR_TOPICS WHERE ID='"+request.getParameter("t")+"'");
    rs = stm.executeQuery();
    if(rs.next())
    	title = rs.getString("TITLE");
    %>
 
	<div class="item"><h1>Welcome to SportsYEAH!</h1>
			<p>
				An Irish Message Board for all things sport, please make sure to post in the appropriate forum.
				 <% if(loggedIn==null||!loggedIn){%>
				 If this is your first time visiting remember to <a href="register.jsp">register</a>. Or if you are not currently signed in remember to <a href="login.jsp">login</a>!
				<%} else { %>
				 Please read the forum <a href = "#">charter</a> before posting.
			<%} %>
			</p>		
		</div>
		<div class="item">
			<div class="title"><%= title %></div><hr/>
			<table border="1" width="100%">
			<thead>
				<tr><td width="75%">Thread</td><td width="25%">Posted By</td></tr>
			</thead>
			<tbody>
				<%String topicSelect = "SELECT * FROM ANDREUR_POSTS WHERE TOPIC_ID='"+request.getParameter("t")+"'ORDER BY CREATED ASC";
				stm = con.prepareStatement(topicSelect);
				rs = stm.executeQuery();
				while(rs.next())
				{%>
					<tr>
					<td>
					<%=rs.getString("CONTENT") %>
					</td>
					<td>
					<%if(rs.getString("USERNAME")==null)out.println("Deleted User");else out.println("<a href=\"profile.jsp?user="+rs.getString("USERNAME")+"\">"+rs.getString("USERNAME")+"</a>"); %><br/>
					<%=rs.getString("CREATED") %>
					</td>
					</tr>
				<%}
				%>
			</tbody>
			</table>
		</div>
		<div class="item">
		<h1>Leave a reply!</h1>
		<br/>
		<% if(loggedIn==null||!loggedIn){%>
		You must <a href="login.jsp">login</a> if you wish to reply. If you do not have an account you can <a href="register.jsp">register</a>.
		<%} else { %>
			<form action="PostServlet" method="POST">
					<label>Message</label><textarea cols="80" rows="10" name="content">Post your reply in here.</textarea>
					<input type="hidden" name="topic" value="<%=request.getParameter("t")%>">
					<br />
					<button type="submit">Post</button>
			</form>
		<%} %>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>