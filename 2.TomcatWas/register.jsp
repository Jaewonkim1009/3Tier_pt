<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
    // 한글 관련 UTF-8 처리
    request.setCharacterEncoding("UTF-8");

    // 로그인 세션 정보 체크 후 리디렉션
    Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
    if (isLoggedIn != null && isLoggedIn) {
        response.sendRedirect("/");
        return;
    }

    // 환경 변수에서 DB 연결 정보 가져오기
    String dbName = System.getenv("MYSQL_DATABASE");
    String dbUser = System.getenv("MYSQL_USER");
    String dbPassword = System.getenv("MYSQL_PASSWORD");
    String hostname = System.getenv("MYSQL_HOST");
    String port = System.getenv("MYSQL_PORT");

    // JDBC URL
    String dbUrl = "jdbc:mariadb://" + hostname + ":" + port + "/" + dbName + "?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // MariaDB 드라이버 로드
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // users 테이블이 존재하는지 확인
        DatabaseMetaData dbm = conn.getMetaData();
        rs = dbm.getTables(null, null, "users", null);

        // users 테이블이 없으면 생성
        if (!rs.next()) {
            stmt = conn.createStatement();
            String createTableSQL = "CREATE TABLE users ("
                + "id INT AUTO_INCREMENT PRIMARY KEY,"
                + "username VARCHAR(255) NOT NULL,"
                + "password VARCHAR(255) NOT NULL,"
                + "score INT DEFAULT 0,"
                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")";
            stmt.executeUpdate(createTableSQL);
        }
    } catch (Exception e) {
        session.setAttribute("registerError", "데이터베이스 연결 오류: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        // 사용자 입력 값
        String newUsername = request.getParameter("newUsername");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 비밀번호 확인
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("registerError", "비밀번호가 일치하지 않습니다.");
            response.sendRedirect("ResisterPage");
            return;
        }

        try {
            // 사용자 이름 중복 확인
            String checkUserSQL = "SELECT username FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(checkUserSQL);
            pstmt.setString(1, newUsername);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                session.setAttribute("registerError", "이미 사용 중인 사용자 이름입니다.");
                response.sendRedirect("ResisterPage");
                return;
            }

            // SQL 쿼리 실행
            String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newUsername);
            pstmt.setString(2, newPassword);

            pstmt.executeUpdate();

            // 성공적으로 회원가입한 경우, 메인 페이지로 리디렉션
            response.sendRedirect("/");
            return;

        } catch (Exception e) {
            session.setAttribute("registerError", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
            response.sendRedirect("ResisterPage");
            return;
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 페이지</title>
    <link rel="stylesheet" href="tomcat.css">
</head>
<body>
    <div class="register-container">
        <h2 class="register-title">회원가입</h2>
        
        <%-- 에러 메시지 표시 --%>
        <% if (session.getAttribute("registerError") != null) { %>
            <div class="error-message">
                <%= session.getAttribute("registerError") %>
            </div>
            <% session.removeAttribute("registerError"); %>
        <% } %>

        <form method="post" action="ResisterPage">
            <div class="form-group">
                <label for="newUsername">사용자 이름</label>
                <input type="text" id="newUsername" name="newUsername" placeholder="새로운 사용자 이름" required>
            </div>
            <div class="form-group">
                <label for="newPassword">비밀번호</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 재입력" required>
            </div>
            <button type="submit" class="register-submit-button">회원가입</button>
            <button type="button" class="cancel-button" onclick="location.href='/'">취소</button>
        </form>
    </div>
</body>
</html>