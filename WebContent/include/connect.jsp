<%@ page import="java.sql.*;" %>
<!-- Simply opens our database connection, is closed again in footer.jsp which is always included -->
<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = null;
	con = DriverManager.getConnection("jdbc:oracle:thin:@136.206.35.131:1521:SSD", "ee_user", "ee_pass");
	
%>