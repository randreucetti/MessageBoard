<!-- Displays topics in a forum and allows user to create new topics -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>SportsYEAH! <%=request.getParameter("f") %> forum</title>
</head>
<body>
	 <%@ include file="include/header.jsp" %>
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
		<a href="post.jsp?f=<%=request.getParameter("f") %>" class="button white">New Topic</a>
		<div class="item">
			<table border="1" width="100%">
			<thead>
				<tr><td width="50%">Thread</td><td width="30%">Last Post</td><td width="10%">Replies</td></tr>
			</thead>
			<tbody>
				<%String topicSelect = "SELECT * FROM ANDREUR_TOPICS WHERE FORUM='"+request.getParameter("f")+"'ORDER BY CREATED DESC";
				PreparedStatement stm = con.prepareStatement(topicSelect);
				ResultSet rs = stm.executeQuery();
				while(rs.next())
				{%>
					<tr>
					<td width="50%"><a href="topicdisplay.jsp?t=<%=rs.getString("ID") %>"><%=rs.getString("TITLE") %></a></td>
					<td width="30%">By: <%if(rs.getString("USERNAME")==null)out.println("Deleted User");else out.println("<a href=\"profile.jsp?user="+rs.getString("USERNAME")+"\">"+rs.getString("USERNAME")+"</a>"); %></td>
					<% PreparedStatement stm2 = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_POSTS WHERE TOPIC_ID ='"+rs.getString("ID")+"'");
						ResultSet rs2 = stm2.executeQuery();
						rs2.next(); %>
					<td width="10%"> <%= rs2.getInt("COUNT(*)") %> replies</td>
					</tr>
				<%}
				%>
			</tbody>
			</table>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>