<!-- Displays a users profile -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>View Profile</title>
</head>
<body>
	 <%@ include file="include/header.jsp" %>
	 <%	PreparedStatement stm;
	 	ResultSet rs;%>
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
		<%if(request.getParameter("user")!=null){//if viewing somebody elses profile %>
			<div class="item">
				<h1>Profile of <%=request.getParameter("user") %></h1>
				<div class="item">
							<h1>Profile Stats</h1><br/>
							<table border="1" width="50%">
							<thead><tr><td width=20%>Number of Posts</td><td width=40%>First Posted</td><td width=40%>Last Posted</td></tr></thead>
								<%stm = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_POSTS WHERE USERNAME='"+request.getParameter("user")+"'");
								rs = stm.executeQuery();
								rs.next();%>
							<tbody><tr><td><%=rs.getInt("COUNT(*)") %></td>
								<%stm = con.prepareStatement("SELECT CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+request.getParameter("user")+"' ORDER BY CREATED ASC");
								rs = stm.executeQuery();
								rs.next();%>
							<td><%=rs.getString("CREATED") %></td>
								<%stm = con.prepareStatement("SELECT CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+request.getParameter("user")+"' ORDER BY CREATED DESC");
								rs = stm.executeQuery();
								rs.next();%>
							<td><%=rs.getString("CREATED") %></td>
							</tr></tbody>
							</table>
							</div>
							
							<div class="item">
							<h1>Posts</h1><br/>
							<table border="1" width="100%">
							<thead><tr><td width=5%>Link</td><td width=70%>Post</td><td width=40%>Details</td></tr></thead>
								<%stm = con.prepareStatement("SELECT TOPIC_ID,CONTENT,CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+request.getParameter("user")+"'");
								rs = stm.executeQuery();
								while(rs.next()){%>
							<tbody><tr><td><a href="topicdisplay.jsp?t=<%=rs.getInt("TOPIC_ID") %>"><img src="images/goto.png"></a></td>
							<td><%=rs.getString("CONTENT") %></td>
							<td><%=rs.getString("CREATED") %></td>
							</tr>
							<%} %>
							</tbody>
							</table>
							</div>
				
			</div>
		<%}else{ //trying to access your own profile 
				if(loggedIn==null||!loggedIn){//not logged in %>
				<div class="item">
						<h1>Welcome to your profile</h1>
						You must be logged in to view your profile!
				
					</div>
				<%}else { %>
					<div class="item">
						<h1>Welcome to your profile</h1>
							Click <a href="changePass.jsp">here</a> to change your password.
							<div class="item">
							<h1>Profile Stats</h1><br/>
							<table border="1" width="100%">
							<thead><tr><td width=20%>Number of Posts</td><td width=40%>First Posted</td><td width=40%>Last Posted</td></tr></thead>
								<%stm = con.prepareStatement("SELECT COUNT(*) FROM ANDREUR_POSTS WHERE USERNAME='"+session.getAttribute("USERNAME")+"'");
								rs = stm.executeQuery();
								rs.next();%>
							<tbody><tr><td><%=rs.getInt("COUNT(*)") %></td>
								<%stm = con.prepareStatement("SELECT CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+session.getAttribute("USERNAME")+"' ORDER BY CREATED ASC");
								rs = stm.executeQuery();
								rs.next();%>
							<td><%=rs.getString("CREATED") %></td>
								<%stm = con.prepareStatement("SELECT CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+session.getAttribute("USERNAME")+"' ORDER BY CREATED DESC");
								rs = stm.executeQuery();
								rs.next();%>
							<td><%=rs.getString("CREATED") %></td>
							</tr></tbody>
							</table>
							</div>
							
							<div class="item">
							<h1>Posts</h1><br/>
							<table border="1" width="100%">
							<thead><tr><td width=5%>Link</td><td width=70%>Post</td><td width=40%>Details</td></tr></thead>
								<%stm = con.prepareStatement("SELECT TOPIC_ID,CONTENT,CREATED FROM ANDREUR_POSTS WHERE USERNAME='"+session.getAttribute("USERNAME")+"'");
								rs = stm.executeQuery();
								while(rs.next()){%>
							<tbody><tr><td><a href="topicdisplay.jsp?t=<%=rs.getInt("TOPIC_ID") %>"><img src="images/goto.png"></a></td>
							<td><%=rs.getString("CONTENT") %></td>
							<td><%=rs.getString("CREATED") %></td>
							</tr>
							<%} %>
							</tbody>
							</table>
							</div>
					</div>
				<%} %>
			<%} %>
		<%@ include file="include/footer.jsp" %>
</body>
</html>