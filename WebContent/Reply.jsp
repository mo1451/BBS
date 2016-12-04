<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int id = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reply</title>
</head>
<body>
	<form method="get" action="ReplyOk.jsp">
		<input type="hidden" name="id" value=<%= id %> >
		<input type="hidden" name="rootid" value=<%= rootid %> >
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
					<a href="ShowArticleTree.jsp?rootid=<%= rootid %>">返回</a>
					
				</td>
				<td align="right">
					<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>