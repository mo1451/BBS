<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
    
<%@ page import="java.sql.*" %>

<% 
	int pageNo = 1;
	int totalPage = 0;
	int pageTot = 5;
	if(request.getParameter("pageNo") != null)
	{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	}
	boolean login = false;
	String admin = (String)session.getAttribute("login");
	if(admin != null && admin.equals("true")) {
		login = true;
	}
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs?" + "user=root&password=root&useSSL=false");
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select count(*) from article where pid = 0");
	rs.next();
	totalPage = rs.getInt(1)%pageTot == 0 ? rs.getInt(1) / pageTot : (rs.getInt(1) / pageTot) + 1; 
	if(pageNo <= 0) {
		pageNo = 1;
	} else if(pageNo > totalPage) {
		pageNo = totalPage;
	}
	session.setAttribute("pageNo", pageNo);
	int pageStart = (pageNo-1)*pageTot;
	rs = stmt.executeQuery("select * from article where pid = 0 limit " + pageStart + "," + pageTot);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Show Article Tree</title>
</head>
<body>
	<table width="100%">
		<tr>
			<td>
				<a href="Post.jsp">发表新帖</a>
			</td>
			<td align="right">
				<%
				if(session.getAttribute("login") == null || !session.getAttribute("login").equals("true")) {
				%>
				<a href="Login.jsp">管理员登录</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				} else {
				%>
				Welcome!admin&nbsp;<a href="logOff.jsp">注销</a>
				<%
				}
				%>
			</td>
		</tr>
	</table>
	
	
	<table border="1" width="100%">
	<%
	String str = "";
	String loginStr = "";
	while(rs.next()) {
		if(session.getAttribute("login") != null &&session.getAttribute("login").equals("true")) {
			loginStr = "<td width='90'><a href='Delete.jsp?id=" + rs.getInt("id") + "&pid=" +
		               rs.getInt("pid") + "&rootid=" + rs.getInt("rootid") + "'>删除</a>";
		}
		str += "<tr><td><a href='ShowArticleTree.jsp?rootid=" + rs.getInt("rootid") + "&pageNo=" + pageNo + "'>" + rs.getString("title") + "</a>" + loginStr + "</tr></td>";
	}
	out.print(str);
	rs.close();
	stmt.close();
	conn.close();
	%>
	</table>
	<table><tr><td>第<%= pageNo %>页&nbsp;&nbsp;共<%= totalPage %>页</td>
	<td>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo - 1 %>">上一页</a>
	<% if((pageNo-2) > 0) { 
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo - 2 %>"><%= pageNo - 2 %></a>
	<% } 
	   if((pageNo-1) > 0) { 
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo - 1 %>"><%= pageNo - 1 %></a>
	<% } 
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo - 0 %>"><%= pageNo - 0 %></a>
	<% if((pageNo+1) <= totalPage) {
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo + 1 %>"><%= pageNo + 1 %></a>
	<% } 
	   if((pageNo+2) <= totalPage) {
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo + 2 %>"><%= pageNo + 2 %></a>
	<% }
	%>
	<a href="ShowArticleFlag.jsp?pageNo=<%= pageNo + 1 %>">下一页</a>
	</td>
	<td>
	<form name="go" action="ShowArticleFlag.jsp" onchange="document.go.submit()">
		<select name="pageNo">
			<%
			for(int i=1;i<=totalPage;i++) {
			%>
				<option value=<%= i %> <%= i==pageNo?"selected":"" %>>第<%= i %>页</option>
			<%	
			}
			%>
		</select>
	</form>
	</td>
	</tr>
	</table>
</body>
</html>