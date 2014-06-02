<!-- This page allows a user to change their password, also allows password reset -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="CSS/theme.css" />
<title>Change your Password</title>
</head>
<body>
	 <%@ include file="include/header.jsp" %>
	 <%PreparedStatement stm;
	 	ResultSet rs;
	 String userName = null;
	 if(request.getParameter("user")!=null)	//gets the user whos password we want to change
		 userName = request.getParameter("user");
	 else if(session.getAttribute("USERNAME")!=null)
		  userName = (String) session.getAttribute("USERNAME");%>
	<div class="item"><h1>Please fill in the following details.</h1>
		<br />
		<% if(userName==null)	//no user specified
			out.println("Something has gone wrong. Click <a href=\"index.jsp\">here</a> to go back to homepage.");
			else{%>
				<%stm = con.prepareStatement("SELECT QUESTION FROM ANDREUR_USERS WHERE USERNAME=?");
				  stm.setString(1, userName);
					rs = stm.executeQuery();
					if(rs.next()){ %>
				<form action="PasswordServlet"method="POST">
					<label><%if(rs.getString("QUESTION").equals("mother"))
								out.print("Mothers maiden name?");
							if(rs.getString("QUESTION").equals("pet"))
								out.print("Name of first pet?");
							if(rs.getString("QUESTION").equals("car"))
								out.print("Make of first car?");%></label><input type="text" name="answer" value="" maxlength="25"> <br />
					<label>New Password</label> <input type="password" name="password" value="" maxlength="25"><br />
					<input type="hidden" name="user" value="<%=userName%>">
					<button type="submit">Submit</button>
				</form>	
			<%}else{out.println("Specifed user "+userName+" does not exist. Click <a href=\"index.jsp\">here</a> to go back to homepage.");
			}} %>
	</div>
		<%@ include file="include/footer.jsp" %>
</body>
</html>