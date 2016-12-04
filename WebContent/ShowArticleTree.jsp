<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
    
<%@ page import="java.sql.*" %>

<%!
String str ="";
private void recu(int pid,Connection conn, int level,boolean login,int rootid) {
	Statement stmt = null;
	ResultSet rs = null;
	String preStr = "";
	for(int i=0;i<level;i++) {
		preStr += "&nbsp;&nbsp;&nbsp;&nbsp;";
	}
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = " + pid + " and rootid = " + rootid);
		String loginStr = "";
		while(rs.next()) {
			if(login) {
				loginStr = "&nbsp;&nbsp;&nbsp;<a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" +
			               rs.getInt("pid") + "&rootid=" + rs.getInt("rootid") + "'>删除</a>";
			} else {
				loginStr = "";
			}
			String replyStr = "<a href = 'Reply.jsp?id=" + rs.getInt("id") + "&rootid=" + rs.getInt("rootid") + "'>回复</a>";
			str += "<tr><td>" + rs.getString("id") + "</td>\n" + "<td>" + preStr + 
					"<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + rs.getString("title") +"</a>" +
					"</td><td width='90'>" + replyStr + loginStr + "</td></tr>\n";
			if(rs.getInt("isleaf") != 0) {
				recu(rs.getInt("id"), conn, level+1,login,rootid);
			}
		}
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
	boolean login = false;
	String admin = (String)session.getAttribute("login");
	int pageNo = (Integer)session.getAttribute("pageNo");
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	if(admin != null && admin.equals("true")) {
		login = true;
	}
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" + "user=root&password=root&useSSL=false");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article");
	str = "";
	recu(0,conn,0,login,rootid);
	rs.close();
	stmt.close();
	conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Show Article Tree</title>
</head>
<body>

	<a href="Post.jsp">发表新帖</a>
	
	<table border="1" width="100%">
	<% out.print(str); %>
	</table>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo %>">返回</a>
</body>
</html>