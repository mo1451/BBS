<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" + "user=root&password=root&useSSL=false");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where id =" + request.getParameter("id"));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Show Article Detail</title>
</head>
<body>
<div align="center">
<%
while(rs.next()) {
%>

	<table align="center" border="1">
		<tr>
			<td width="100">ID</td>
			<td width="400"><%= rs.getInt("id") %></td>
		</tr>
		<tr>
			<td>Title</td>
			<td><%= rs.getString("title") %></td>
		</tr>
		<tr>
			<td>Content</td>
			<td height="200" valign="top"><%= rs.getString("cont") %></td>
		</tr>
	</table>
	<a href="ShowArticleTree.jsp?rootid=<%= rs.getInt("rootid") %>">返回</a>
	<a href="Reply.jsp?id=<%= rs.getInt("id") %>&rootid=<%= rs.getInt("rootid") %>">回复</a>
	<%
	String admin = (String)session.getAttribute("login");
	if(admin != null && admin.equals("true")) {
	%>
	<a href="Delete.jsp?id=<%= rs.getInt("id") %>&pid=<%= rs.getInt("pid") %>&rootid=<%= rs.getInt("rootid") %>">删除</a>

<%
	}
}
rs.close();
stmt.close();
conn.close();
%>
</div>

</body>
</html>