<!-- This file is included at the top of all jsp files.
It connects to the database incase we need to access it and loads the header of the page. -->
<%@ include file="connect.jsp"  %>
<%	
Boolean loggedIn= (Boolean) session.getAttribute("loggedIn"); //gets the logged in attribute if its been created%>
<div class="header">
	<div class="middle">
	<!-- loads our logo -->
		<div class="logo"><a href="index.jsp"><img src="images/logo.png"></a></div>
		<div class ="actions">
			<% if(loggedIn==null||!loggedIn){%> <!-- Display this if not logged in -->
				Click <a href="login.jsp">here</a> to go to your login.<br />
				Forgotten your password? Click <a href="forgot.jsp">here</a><br />
				Not a member? Click <a href="register.jsp">here</a> to register!
			<%} else { %> <!--  otherwise display this -->
				Welcome <%= session.getAttribute("USERNAME") %> <a href="LogoutServlet">Logout</a> <br/>
				Click <a href="profile.jsp">here</a> to go to your profile.
			<%} %>
				
		</div>
	</div>
</div>
<div class ="content">
	<div class="middle">	<!-- page relevant info will be below -->