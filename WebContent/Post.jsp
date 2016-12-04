<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
<%
String action = request.getParameter("action");
if(action != null && action.equals("post")) {
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	int pageNo = (Integer)session.getAttribute("pageNo");
	cont = cont.replace("\r\n", "<br>");
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?user=root&password=root&useSSL=false");
	
	String sql = "insert into article values (null,?,?,?,?,now(),?)";
	
	conn.setAutoCommit(false);
	PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
	pstmt.setInt(1, 0);
	pstmt.setInt(2, -1);
	pstmt.setString(3, title);
	pstmt.setString(4,cont);
	pstmt.setInt(5,0);
	pstmt.execute();
	
	ResultSet rs = pstmt.getGeneratedKeys();
	rs.next();
	int rootid = rs.getInt(1);
	rs.close();
	Statement stmt = conn.createStatement();
	stmt.executeUpdate("update article set rootid = " + rootid + " where id = " + rootid);
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	response.sendRedirect("ShowArticleFlag.jsp?pageNo=" + pageNo);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reply</title>
</head>
<body>
	<form method="get" action="Post.jsp">
		<input type="hidden" name="action" value="post" >
		<table>
			<tr>
				<td>Title</td>
				<td>
					<input type="text" name="title" size="106">
				</td>
			</tr>
			<tr>
				<td>Content</td>
				<td>
					<textarea rows="20" cols="80" name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>