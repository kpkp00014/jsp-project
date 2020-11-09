<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD><TITLE>로그인 확인</TITLE></HEAD>
<BODY>
<div align="center">
<H2>메인 화면 </H2>
<HR>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.*" %>
<%
if(session.getAttribute("username")!=null){
    if(session.getAttribute("room")!=null) {
        response.sendRedirect("room.jsp");
    }
%>
    
    # <%= session.getAttribute("username") %> 님 환영 합니다.!!!!<BR>
    1. 세션 ID : <%= session.getId() %> <BR>
    2. 세션 유지시간 : <%= session.getMaxInactiveInterval() %> <BR>
    <form action="logout.jsp">
    <button>로그아웃</button>
    </form>
    
    <div>
    <form method=POST action=createRoom.jsp>
        <input name=r_name type="text"/>
        <input type=submit value=방만들기>
    </form>
    <table border='1'>
        <tr><th>방 번호</th><th>방 이름</th><th>인원수</th></tr>
        <%
        for(RoomBean room : rm.getRoomList()) {
        %>
            <tr>
            <td><%=room.getR_id() %></td>
            <td><a href="enterRoom.jsp?rm=<%=room.getR_id()%>"><%=room.getR_name() %></a></td>
            <td><%=room.getR_memberSize() %>/4</td>
            </tr>
        <%
        }
        %>
    </table>
    </div>
    <%
}
else {
    %>
    <a href="/web2020/project/register_form.html">회원가입</a>
    <a href="/web2020/project/login_form.html">로그인</a>
    <%
}
%>
</BODY>
</HTML>