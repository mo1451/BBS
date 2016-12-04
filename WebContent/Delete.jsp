<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
<%!
private void delete(int pid,Connection conn,int rootid) {
	Statement stmt = null;
	ResultSet rs = null;
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = " + pid + " and rootid = " + rootid);
		int id = 0;
		while(rs.next()) {
			id = rs.getInt("id");
			delete(id, conn, rootid);
		}
		stmt.executeUpdate("delete from article where id = " + pid + " and rootid = " + rootid);//原为id，删不干净，现为pid，可以删除。
	} catch(SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
%>    
    
<%
String admin = (String)session.getAttribute("login");
if(admin != null && admin.equals("true")) {
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	int count = 0;
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("Jdbc:mysql://localhost/bbs?user=root&password=root&useSSL=false");
	Statement stmt = conn.createStatement();

	conn.setAutoCommit(false);
	delete(pid,conn,rootid);
	ResultSet rs = stmt.executeQuery("select count(*) from article where pid =" + id + " and rootid = " + rootid);
	while(rs.next()) {
		count = rs.getInt(1);
	}
	if(count <= 0) {
		stmt.executeUpdate("update article set isleaf = 0 where id =" + pid + " ane rootid = " + rootid);
	}
	conn.commit();
	conn.setAutoCommit(true);

	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect("ShowArticleFlag.jsp?pageNo=" + (Integer)session.getAttribute("pageNo"));
} else {
	out.print("错误!管理员未登录");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>