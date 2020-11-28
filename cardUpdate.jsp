<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%
    //방번호 get
    String sessionId = (String) session.getId();
    Integer rNum = (Integer) session.getAttribute("room");
    RoomBean room = new RoomBean();
    // 현재 방 선택
    for(RoomBean r : rm.getRoomList()) {
        if(r.getR_id()==rNum) {
          room = r;
          break;
        }
    }
    int index = Integer.parseInt(request.getParameter("index"));
    room.useCard(sessionId, index);
    response.sendRedirect("room.jsp");
%>
