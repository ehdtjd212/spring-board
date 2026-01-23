<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리집 미션 보드 - 로그인</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: #f0f2f5; margin: 0; }
    .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); text-align: center; width: 300px; }
    h2 { margin-bottom: 20px; color: #333; }
    input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 10px; }
    button:hover { background-color: #45a049; }
    .error { color: red; font-size: 14px; margin-bottom: 10px; }
</style>
</head>
<body>

<div class="login-box">
    <h2>🏠 우리집 로그인</h2>

    <% if(request.getParameter("error") != null) { %>
        <p class="error">아이디 또는 비밀번호가 틀렸어요!</p>
    <% } %>

    <form action="/loginAction" method="post">
        <input type="text" name="id" placeholder="아이디 (admin, jaewoo, jaei)" required>
        <input type="password" name="pw" placeholder="비밀번호" required>
        <button type="submit">입장하기</button>
    </form>
</div>

</body>
</html>