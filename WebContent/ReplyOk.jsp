<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>

<%
int id = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
String title = request.getParameter("title");
String cont = request.getParameter("cont");
cont = cont.replace("\r\n", "<br>");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?user=root&password=root&useSSL=false");
String sql = "insert into article values (null,?,?,?,?,now(),?)";
conn.setAutoCommit(false);
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setInt(1, id);
pstmt.setInt(2, rootid);
pstmt.setString(3, title);
pstmt.setString(4,cont);
pstmt.setInt(5,0);
pstmt.execute();
Statement stmt = conn.createStatement();
stmt.executeUpdate("update article set isleaf = 1 where id = " + id);
conn.commit();
conn.setAutoCommit(true);
stmt.close();
pstmt.close();
conn.close();
response.sendRedirect("ShowArticleTree.jsp?rootid=" + rootid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%= cont %>
</body>
</html>