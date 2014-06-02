<!-- About the site -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>About Sports YEAH!</title>
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
			<h1>About Sports Yeah!</h1><br />
			Sports Yeah! was designed by <a href="http://www.dcu.ie/">Dublin City University</a> student Ross Andreucetti as part of an assignment for module EE417. 
			Ross is studying for his Masters in Telecommunications Engineering. This website uses Java Servlets as well as JavaServer pages to allow users all the functionality
			 that Sports Yeah! currently offers. 
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>