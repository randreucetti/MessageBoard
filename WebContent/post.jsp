<!-- This page allows user to create new topics -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Post a message</title>
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
		<h1>Create a new topic!</h1>
		<br />
		 <% if(loggedIn==null||!loggedIn){%>
		 You must <a href="login.jsp">login</a> if you wish to create a new topic. If you do not have an account you can <a href="register.jsp">register</a>.
		 <%} else { %>
			<form action="PostServlet" method="POST" class="post">
				<label>Title</label> <input type="text" name="title" value=""size="30" maxlength="30">
				<br />
					<label>Message</label><textarea cols="40" rows="5" name="content">Post your message in here.</textarea>
					<input type="hidden" name="forum" value="<%=request.getParameter("f")%>"><br />
					<button type="submit">Post</button>
			</form>
			<%} %>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>