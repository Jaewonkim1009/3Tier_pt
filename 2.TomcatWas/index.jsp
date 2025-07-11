<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="tomcat.css">
<style>
    @keyframes loginFormAppear {
        0% {
            opacity: 0;
            transform: translate3d(0, -30px, 0) scale(0.95);
        }

        100% {
            opacity: 1;
            transform: translate3d(0, 0, 0) scale(1);
        }
    }

    @keyframes inputFocus {
        0% { transform: scale(1); }
        50% { transform: scale(1.02); }
        100% { transform: scale(1); }
    }

    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
</style>

</head>
<body>
    <div class="login-container">
        <% 
            // 로그인 세션 확인
            String username = (String) session.getAttribute("username");
            Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
            
            if(isLoggedIn != null && isLoggedIn) {
        %>
            <h2 class="login-title">환영합니다</h2>
            <div class="message welcome-message">
                <p><%= username %>님 환영합니다!</p>
            </div>
            <div class="button-group">
                <button type="button" class="cancel-button" onclick="location.href='Logout'">로그아웃</button>
            </div>
        <% } else { %>
            <h2 class="login-title">로그인</h2>
            <form action="LoginPage" method="post">
                <div class="form-group">
                    <label for="username">사용자 이름</label>
                    <input type="text" id="username" name="username" placeholder="사용자 이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>
                <button type="submit" class="signup-button">로그인</button>
            </form>
            <p style="margin-top: 20px;">
                <a href="ResisterPage" class="signup-button">회원가입</a>
            </p>
        <% } %>
    </div>
</body>
</html>
