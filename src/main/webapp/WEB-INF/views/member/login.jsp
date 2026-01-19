<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .login-card { width: 100%; max-width: 400px; padding: 30px; border-radius: 10px; background: white; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

    <div class="login-card">
        <h3 class="text-center fw-bold text-primary mb-4">🔐 로그인</h3>

        <c:if test="${param.error}">
            <div class="alert alert-danger text-center">
                아이디 또는 비밀번호가 틀렸습니다.
            </div>
        </c:if>

        <form action="/member/login" method="post">
            <div class="mb-3">
                <input type="text" name="id" class="form-control" placeholder="아이디" required>
            </div>
            <div class="mb-3">
                <input type="password" name="pw" class="form-control" placeholder="비밀번호" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 fw-bold">로그인</button>
        </form>

        <div class="text-center mt-3">
            <a href="/board/list" class="text-secondary text-decoration-none">게시판으로 돌아가기</a>
        </div>
    </div>

</body>
</html>