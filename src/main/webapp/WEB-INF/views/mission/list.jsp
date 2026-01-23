<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리집 칭찬 스티커판</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f0f2f5; }
    h2 { color: #333; }
    .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }

    /* 테이블 스타일 */
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: center; }
    th { background-color: #4CAF50; color: white; }

    /* 상태별 스타일 */
    .status-todo { color: #ff9800; font-weight: bold; }
    .status-done { color: #4CAF50; font-weight: bold; text-decoration: line-through; }

    /* 버튼 스타일 */
    .btn-complete { background-color: #2196F3; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px; }
    .btn-add { background-color: #4CAF50; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; }

    /* 입력 폼 스타일 */
    .input-box { width: 100%; padding: 10px; margin: 5px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    .mission-form { background-color: #eee; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
</style>
</head>
<body>
<div style="text-align: right; margin-bottom: 10px;">
    <span>👋 안녕, <b>${loginUser.name}</b>! (현재 ${loginUser.point} P)</span>
    <a href="/logout" style="margin-left: 10px; color: red; text-decoration: none;">[로그아웃]</a>
    <a href="/shop/list" style="background-color: #e91e63; color: white; padding: 10px 20px; text-decoration: none; border-radius: 10px; margin-left: 10px;">
        🛍️ 상점 가기
    </a>
</div>
<div class="container">
    <div style="display: flex; justify-content: space-between; align-items: center;">
            <h2>👦 ${targetId eq 'jaewoo' ? '재우' : '재이'}의 미션 보드</h2>
            <h3 style="background: gold; padding: 10px; border-radius: 10px;">
                💰 현재 점수: <b>${totalPoint} P</b>
            </h3>
        </div>

    <c:if test="${loginUser.id == 'admin'}">
            <div class="mission-form">
                <h3>✨ 아빠! 새 미션을 주세요</h3>
                <form action="/mission/register" method="post">
                    <input type="hidden" name="targetId" value="${targetId}">
                    <input type="text" name="title" class="input-box" placeholder="미션 내용" required>
                    <input type="number" name="reward" class="input-box" placeholder="보상 포인트" value="100">
                    <button type="submit" class="btn-add">미션 등록하기</button>
                </form>
            </div>
        </c:if>

    <h3>📋 현재 미션 목록</h3>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>할 일</th>
                <th>보상</th>
                <th>상태</th>
                <th>완료하기</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="mission">
                <tr>
                    <td>${mission.mno}</td>
                    <td class="${mission.status == 'DONE' ? 'status-done' : ''}">${mission.title}</td>
                    <td>${mission.reward}P</td>
                    <td>
                        <span class="${mission.status == 'TODO' ? 'status-todo' : 'status-done'}">
                            ${mission.status == 'TODO' ? '진행중 🔥' : '완료 ✅'}
                        </span>
                    </td>
                    <td>
                        <c:if test="${mission.status == 'TODO'}">
                            <form action="/mission/complete" method="post">
                                      <input type="hidden" name="mno" value="${mission.mno}">
                                      <input type="hidden" name="targetId" value="${mission.targetId}">
                                      <input type="hidden" name="reward" value="${mission.reward}">
                                      <button type="submit" class="btn-complete">완료!</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>