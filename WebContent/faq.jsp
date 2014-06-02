<!-- Simple FAQ-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>FAQ</title>
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
			<h1>Sports YEAH! FAQ</h1>
			<ul>
			<li><b>What is Sports YEAH!: </b>Sports Yeah! is an Irish message board where users can post messages and reply about the latest happenings in sport.</li>
			<li><b>I can't post in any topics: </b>Have a go at <a href="login.jsp">logging in</a> or <a href="register.jsp">registering</a>. </li>
			<li><b>Is Sports Yeah! free: </b>Yes and it alway will be.</li>
			<li><b>Who created this website: </b>Have a look in the <a href="about.jsp">about</a> section.</li>
			<li><b>Can you design a website for me: </b>Maybe when I graduate.</li>
			<li><b>What sport is the best: </b><a href="forumdisplay.jsp?f=soccer">Soccer</a></li>
			</ul>
		</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>