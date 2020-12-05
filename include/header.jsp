<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div class="header">
<%
String currentPage = (String) request.getParameter("currentPage");
if(currentPage.equals("index")){
%>
    <a href="/cardstack/ranking.jsp"><h3>랭킹</h3></a>
    <H2>메인화면</H2>
    <a href="/cardstack/board.jsp"><h3>게시판</h3></a>
<%
} else if (currentPage.equals("ranking")){
%>
    <a href="/cardstack/index.jsp"><h3>메인화면</h3></a>
    <H2>랭킹</H2>
    <a href="/cardstack/board.jsp"><h3>게시판</h3></a>
<%
} else if (currentPage.equals("board")) {
%>
    <a href="/cardstack/ranking.jsp"><h3>랭킹</h3></a>
    <H2>게시판</H2>
    <a href="/cardstack/index.jsp"><h3>메인 화면</h3></a>
<%
} else {
%>
    <h3></h3>
    <H2><%=request.getParameter("rname")%></H2>
    <h3></h3>
<%
}
%>
</div>
<hr>