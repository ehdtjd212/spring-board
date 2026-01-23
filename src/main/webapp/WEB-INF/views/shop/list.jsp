<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리집 포인트 상점</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; background-color: #f0f2f5; padding: 20px; }
    .container { max-width: 800px; margin: 0 auto; }

    /* 상단 헤더 */
    .header { display: flex; justify-content: space-between; align-items: center; background: white; padding: 20px; border-radius: 15px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
    .my-point { font-size: 24px; font-weight: bold; color: #ff9800; }
    .btn-back { background-color: #607d8b; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; }

    /* 상품 목록 (카드 형태) */
    .shop-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
    .item-card { background: white; border-radius: 15px; padding: 20px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: transform 0.2s; }
    .item-card:hover { transform: translateY(-5px); }

    .item-icon { font-size: 50px; margin-bottom: 10px; display: block; }
    .item-name { font-size: 18px; font-weight: bold; margin-bottom: 10px; color: #333; }
    .item-cost { color: #e91e63; font-weight: bold; font-size: 20px; margin-bottom: 15px; }

    .btn-buy { background-color: #2196F3; color: white; border: none; padding: 10px 20px; border-radius: 20px; cursor: pointer; width: 100%; font-size: 16px; }
    .btn-buy:hover { background-color: #1976D2; }
</style>
<script>
    // 페이지 열릴 때 메시지 확인 (구매 성공/실패 알림)
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');

        if (msg === 'success') {
            alert('🎉 구매 성공! 아이템을 획득했습니다.');
        } else if (msg === 'fail') {
            alert('😱 잔액이 부족해요! 미션을 더 수행하세요.');
        }
    }

    // 구매 버튼 누를 때 한번 더 물어보기
    function confirmBuy(name, cost) {
        return confirm(name + '을(를) ' + cost + '포인트에 구매하시겠습니까?');
    }
</script>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h2>🏪 포인트 상점</h2>
            <div class="my-point">💰 내 지갑: ${point} P</div>
        </div>
        <a href="/mission/list?targetId=${loginUser.id}" class="btn-back">🔙 미션판으로</a>
    </div>

    <div class="shop-grid">
        <c:forEach items="${list}" var="item">
            <div class="item-card">
                <span class="item-icon">🎁</span>
                <div class="item-name">${item.name}</div>
                <div class="item-cost">${item.cost} P</div>

                <form action="/shop/buy" method="post" onsubmit="return confirmBuy('${item.name}', ${item.cost})">
                    <input type="hidden" name="ino" value="${item.ino}">
                    <button type="submit" class="btn-buy">구매하기</button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>