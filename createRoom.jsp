<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.util.*"%>
<jsp:useBean id="rm" class="project.room.RoomManager" scope="application"/>
<%@ page import="project.room.RoomBean" %>
<%
    // 방 생성
    RoomBean room = new RoomBean();
    String rName = request.getParameter("r_name");
    Integer rnumber = (Integer) application.getAttribute("rnumber");
    if(rnumber == null) {
        rnumber = 1;
    } 
    application.setAttribute("rnumber", rnumber+1);
    room.setR_id(rnumber);
    room.setR_name(rName);

    // 방 목록에 방 추가
	rm.add(room);
    session.setAttribute("room", rnumber);
    response.sendRedirect("room.jsp");
%>