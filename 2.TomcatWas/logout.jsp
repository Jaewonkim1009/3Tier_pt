<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // 세션 종료
    response.sendRedirect("/"); // 메인 페이지로 리다이렉트
%>