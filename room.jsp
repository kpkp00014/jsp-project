<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" errorPage="error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%= session.getAttribute("username") %> 님 환영 합니다.!!!!<BR>
<%
    
    Integer rNum = (Integer) session.getAttribute("room");
    RoomBean room = new RoomBean();
    // 현재 방 선택
    for(RoomBean r : rm.getRoomList()) {
        if(r.getR_id()==rNum) {
          room = r;
          break;
        }
    }

    String sessionUser = (String) session.getAttribute("username");

    // 방 멤버 목록에 추가되어있지 않다면,  추가한다
    if(!room.existR_member(sessionUser)){
        room.addR_member(sessionUser);
    }
%>
<%=session.getAttribute("room")%><br>
<%=room.existR_member(sessionUser)%>
<h4>방 이름 : <%=room.getR_name()%></h4>
<h4>멤버 목록 : <%=room.getR_member()%></h4>

<form action='exitRoom.jsp'>
<input type='submit' value='나가기'>
</form>