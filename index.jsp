<%@ page language="java" contentType="text/html; charset=UTF-8" import="javax.sql.*,java.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>CardStack60</TITLE>
<link href="style.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div align="center">
<jsp:include page="include/header.jsp">
    <jsp:param name="currentPage" value="index"/>
</jsp:include>
<%
if(session.getAttribute("username")!=null){
%>
    <%@ include file="/include/index_Login.jsp"%>

    
    <%
}
else {
    %>
    <%@ include file="/include/index_noLogin.jsp"%>
    <%
}
%>
<%@ include file="/include/footer.jsp"%>
</div>
</BODY>
</HTML>