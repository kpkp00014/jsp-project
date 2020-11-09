<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%
   //방번호 get
    Integer rNum = (Integer) session.getAttribute("room");
    RoomBean room = new RoomBean();
    String sessionUser = (String) session.getAttribute("username");
    // 현재 방 선택
    for(RoomBean r : rm.getRoomList()) {
        if(r.getR_id()==rNum) {
          room = r;
          break;
        }
    }
    // 방 멤버에서 뺀다
    room.removeR_member(sessionUser);
    session.removeAttribute("room");

    // 방 남은 멤버수가 0이면, 삭제
    if(room.getR_memberSize()==0) {
        rm.remove(room);
    }
    response.sendRedirect("index.jsp");
%>
