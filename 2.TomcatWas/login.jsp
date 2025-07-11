<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
    // 로그인 세션 정보 체크후 리디렉션
    Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
    if (isLoggedIn != null && isLoggedIn) {
        response.sendRedirect("/");
        return;
    }

    // 한글 관련 UTF-8 처리
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean loginSuccess = false;

    // 환경 변수에서 DB 연결 정보 가져오기
    String dbName = System.getenv("MYSQL_DATABASE");
    String dbUser = System.getenv("MYSQL_USER");
    String dbPassword = System.getenv("MYSQL_PASSWORD");
    String hostname = System.getenv("MYSQL_HOST");
    String port = System.getenv("MYSQL_PORT");

    String dbUrl = "jdbc:mariadb://" + hostname + ":" + port + "/" + dbName + "?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MariaDB 드라이버 로드
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            loginSuccess = true;

            // 로그인 정보를 세션에 저장
            session.setAttribute("username", username);
            session.setAttribute("loggedIn", true);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 결과</title>
    <link rel="stylesheet" href="tomcat.css">
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">로그인 결과</h2>
        <% if (loginSuccess) { %>
            <div class="message welcome-message">
                <p>로그인에 성공했습니다!</p>
                <p>환영합니다, <%= username %>님!</p>
            </div>
            <div class="button-group">
                <button type="button" class="cancel-button" onclick="location.href='Logout'">로그아웃</button>
            </div>
        <% } else { %>
            <div class="message error-message">
                <p>로그인에 실패했습니다.</p>
                <p>사용자 이름 또는 비밀번호를 확인해주세요.</p>
            </div>
            <div class="button-group">
                <button type="button" class="signup-button" onclick="location.href='/'">다시 시도</button>
                <button type="button" class="cancel-button" onclick="location.href='ResisterPage'">회원가입</button>
            </div>
        <% } %>
    </div>
</body>
</html>
