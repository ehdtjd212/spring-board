<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${targetId}의 미션판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<style>
    body { background-color: #f0f2f5; font-family: 'Noto Sans KR', sans-serif; }

    /* 미션 카드 스타일 */
    .mission-card { border: none; border-radius: 12px; background: white; margin-bottom: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); transition: transform 0.2s; }
    .mission-card:active { transform: scale(0.98); } /* 터치했을 때 살짝 눌리는 효과 */

    .status-badge { font-size: 0.8rem; padding: 5px 10px; border-radius: 20px; }
    .bg-todo { background-color: #e9ecef; color: #495057; }
    .bg-done { background-color: #d4edda; color: #155724; }

    /* 상단 프로필 영역 */
    .profile-section { background: white; padding: 20px; border-radius: 0 0 20px 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
</style>
</head>
<body>

<nav class="navbar navbar-expand bg-primary navbar-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#"><i class="fas fa-home me-2"></i>우리집</a>
        <div class="d-flex align-items-center">
            <span class="text-white me-3 small">${loginUser.name}님</span>
            <a href="/logout" class="btn btn-sm btn-light text-primary fw-bold">로그아웃</a>
        </div>
    </div>
</nav>

<div class="container" style="max-width: 600px;">

    <div class="profile-section text-center">
        <h5 class="text-muted mb-1">현재 보유 포인트</h5>
        <h1 class="fw-bold text-primary mb-3">${loginUser.point} P</h1>

        <div class="d-flex gap-2 justify-content-center">
            <a href="/shop/list" class="btn btn-warning w-100 fw-bold text-dark shadow-sm">
                <i class="fas fa-shopping-cart me-1"></i> 상점 가기
            </a>
            <c:if test="${loginUser.id == 'admin'}">
                 <button class="btn btn-outline-primary w-100" type="button" data-bs-toggle="collapse" data-bs-target="#addMissionBox">
                    <i class="fas fa-plus"></i> 미션 등록
                 </button>
            </c:if>
        </div>
    </div>

    <c:if test="${loginUser.id == 'admin'}">
        <div class="collapse mb-4" id="addMissionBox">
            <div class="card card-body bg-light border-0">
                <h6 class="fw-bold mb-3">✨ 새 미션 만들기</h6>
                <form action="/mission/register" method="post">
                    <input type="hidden" name="targetId" value="${targetId}">
                    <input type="text" name="title" class="form-control mb-2" placeholder="미션 내용 (예: 분리수거)" required>
                    <div class="input-group mb-2">
                        <span class="input-group-text">보상</span>
                        <input type="number" name="reward" class="form-control" value="100">
                        <span class="input-group-text">P</span>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">등록하기</button>
                </form>
            </div>
        </div>
    </c:if>

    <h6 class="text-muted ms-1 mb-3">오늘의 할 일</h6>

    <c:forEach items="${list}" var="mission">
        <div class="mission-card p-3 d-flex justify-content-between align-items-center">
            <div>
                <div class="fw-bold fs-5 mb-1">${mission.title}</div>
                <span class="badge bg-secondary rounded-pill">+${mission.reward} P</span>
                <span class="text-muted small ms-2"><fmt:formatDate value="${mission.regdate}" pattern="MM.dd"/></span>
            </div>

            <c:choose>
                <c:when test="${mission.status == 'DONE'}">
                    <span class="badge bg-success p-2">✅ 완료됨</span>
                </c:when>
                <c:otherwise>
                    <form action="/mission/complete" method="post" style="margin:0;">
                        <input type="hidden" name="mno" value="${mission.mno}">
                        <input type="hidden" name="targetId" value="${targetId}">
                        <button type="submit" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                            완료하기
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>