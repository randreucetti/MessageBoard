<!-- User can user this page to reset a forgotten password -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Forgot Password?</title>
</head>
<body>
	 <%@ include file="include/header.jsp" %>
	
	<div class="item"><h1>Please fill in the following details.</h1>
	 <% if(loggedIn==null||!loggedIn){%>
			<form action="changePass.jsp"method="GET">
				<label>Username</label> <input type="text" name="user" value="" maxlength="25"><br />
				<button type="submit">Submit</button>
			</form>	
	 <%} else{%>
	 <br />
	 You are already logged in! Click <a href ="index.jsp">here</a> to return to the homepage.
	 <%} %>
	
	</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>