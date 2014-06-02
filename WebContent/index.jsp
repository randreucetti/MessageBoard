<!-- The homepage for Sports YEAH! -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Welcome to SportsYEAH!</title>
</head>
<body>
	 <%@ include file="include/header.jsp" %>
	<div class="item"><h1>Welcome to SportsYEAH!</h1> <!-- Depends on if user is logged in or not -->
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
			<!-- All our forums and some forum info is displayed in table -->
			<table border="1" width="100%">
			<thead>
				<tr><td width="50%">Forum</td><td width="40%">Last Topic</td><td width="10%">Threads</td></tr>
			</thead>
			<tbody>
				<% 	PreparedStatement stm;
					ResultSet rs;	
					%>
				<tr><td width="50%"><a href="forumdisplay.jsp?f=soccer">Soccer</a> <br />A forum about soccer</td>
				<%	stm = con.prepareStatement("SELECT ID,TITLE,USERNAME FROM ANDREUR_TOPICS WHERE FORUM='soccer'ORDER BY CREATED DESC ");
					rs = stm.executeQuery();
					if(rs.next()){ //if there is posts in forum%>
					<td width="30%"><a href="topicdisplay.jsp?t=<%= rs.getInt("ID") %>&title=<%=rs.getString("TITLE")%>"><%=rs.getString("TITLE") %></a><br />by <%if(rs.getString("USERNAME")==null)out.println("Deleted User");else out.println("<a href=\"profile.jsp?user="+rs.getString("USERNAME")+"\">"+rs.getString("USERNAME")+"</a>"); %></td>
				<%}else{ %>
					<td width="30%">No posts currently in this forum.</td>
				<%} %>
				<%	stm = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_TOPICS WHERE FORUM='soccer'");
					rs = stm.executeQuery();
					rs.next();%>
				<td width="10%"><%= rs.getInt("COUNT(*)") %></td>
				
				<tr><td width="50%"><a href="forumdisplay.jsp?f=rugby">Rugby</a> <br />A forum about rugby</td>
				<%	stm = con.prepareStatement("SELECT ID,TITLE,USERNAME FROM ANDREUR_TOPICS WHERE FORUM='rugby'ORDER BY CREATED DESC ");
					rs = stm.executeQuery();
					if(rs.next()){%>
						<td width="30%"><a href="topicdisplay.jsp?t=<%= rs.getInt("ID") %>&title=<%=rs.getString("TITLE")%>"><%=rs.getString("TITLE") %></a><br />by <%if(rs.getString("USERNAME")==null)out.println("Deleted User");else out.println("<a href=\"profile.jsp?user="+rs.getString("USERNAME")+"\">"+rs.getString("USERNAME")+"</a>"); %></td>
					<%}else{ %>
						<td width="30%">No posts currently in this forum.</td>
					<%} %>
				<%	stm = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_TOPICS WHERE FORUM='rugby'");
					rs = stm.executeQuery();
					rs.next();%>
				<td width="10%"><%= rs.getInt("COUNT(*)") %></td>
				<tr><td width="50%"><a href="forumdisplay.jsp?f=gaa">GAA</a> <br />A forum about GAA</td>
				<%	stm = con.prepareStatement("SELECT ID,TITLE,USERNAME FROM ANDREUR_TOPICS WHERE FORUM='gaa'ORDER BY CREATED DESC ");
					rs = stm.executeQuery();
					if(rs.next()){ //if there is posts in forum%>
					<td width="30%"><a href="topicdisplay.jsp?t=<%= rs.getInt("ID") %>&title=<%=rs.getString("TITLE")%>"><%=rs.getString("TITLE") %></a><br />by <%if(rs.getString("USERNAME")==null)out.println("Deleted User");else out.println("<a href=\"profile.jsp?user="+rs.getString("USERNAME")+"\">"+rs.getString("USERNAME")+"</a>"); %></td>
				<%}else{ %>
					<td width="30%">No posts currently in this forum.</td>
				<%} %>
				<%	stm = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_TOPICS WHERE FORUM='gaa'");
					rs = stm.executeQuery();
					rs.next();%>
				<td width="10%"><%= rs.getInt("COUNT(*)") %></td>
			</tbody>
			</table>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>