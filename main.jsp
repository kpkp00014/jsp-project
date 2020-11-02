<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD><TITLE>로그인 확인</TITLE></HEAD>
<BODY>
<div align="center">
<H2>메인 화면 </H2>
<HR>
<%
if(session.getAttribute("username")!=null){
%>
    # <%= session.getAttribute("username") %> 님 환영 합니다.!!!!<BR>
    1. 세션 ID : <%= session.getId() %> <BR>
    2. 세션 유지시간 : <%= session.getMaxInactiveInterval() %> <BR>
    <form action="logout.jsp">
    <button>로그아웃</button>
    </form>
    <%
}
else {
    %>
    <a href="/web2020/project/register_form.html">회원가입</a>
    <a href="/web2020/project/login_form.html">로그인</a>
    <%
}
%>
</div>
</BODY>
</HTML>