<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%
session.setAttribute("username", null);
response.sendRedirect("main.jsp");
%>