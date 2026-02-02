<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> <title>우리집 미션 보드</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; } /* 배경색: 아주 연한 회색 */
    .login-container { min-height: 100vh; display: flex; align-items: center; justify-content: center; }
    .card { border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.1); border-radius: 15px; }
    .btn-login { background-color: #4e73df; border: none; padding: 12px; font-weight: bold; border-radius: 10px;}
    .btn-login:hover { background-color: #2e59d9; }
</style>
</head>
<body>

<div class="container login-container">
    <div class="card p-4" style="width: 100%; max-width: 350px;">
        <div class="text-center mb-4">
            <h1 style="font-size: 50px;">🏠</h1>
            <h3 class="fw-bold text-dark">우리집 미션</h3>
            <p class="text-muted small">로그인하고 포인트를 모으세요!</p>
        </div>

        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center p-2 small">
                아이디나 비밀번호를 확인해주세요. 😭
            </div>
        <% } %>

        <form action="/loginAction" method="post">
            <div class="mb-3">
                <input type="text" name="id" class="form-control form-control-lg" placeholder="아이디" required>
            </div>
            <div class="mb-4">
                <input type="password" name="pw" class="form-control form-control-lg" placeholder="비밀번호" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 btn-login">입장하기</button>
        </form>
    </div>
</div>

</body>
</html>