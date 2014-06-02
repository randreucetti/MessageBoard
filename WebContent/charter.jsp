<!-- Forum Charter -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Forum Charter</title>
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
		<div class="item">
			<h1>Sports Yeah! Rules</h1>
			<ul>
				<li>Do not post messages that will offend other users.</li>
				<li>Enjoy yourself while posting and reading</li>
				<li>Try to post in the right forum</li>
				<li>Be nice to each other</li>
			</ul>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>