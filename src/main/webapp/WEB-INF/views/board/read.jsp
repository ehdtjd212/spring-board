<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; max-width: 800px; }
        .content-box { min-height: 300px; white-space: pre-wrap; }
    </style>
</head>
<body>

    <div class="container">
        <div class="card shadow-sm">
            <div class="card-header bg-white p-4">
                <h3 class="fw-bold mb-3">${board.title}</h3>
                <div class="d-flex justify-content-between text-secondary">
                    <span>👤 ${board.writer}</span>
                    <span>
                        📅 <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/> &nbsp;|&nbsp;
                        <span class="text-danger fw-bold">👀 ${viewCount}</span>
                    </span>
                </div>
            </div>

            <div class="card-body p-4 content-box">
                ${board.content}
            </div>

           <div class="card-footer bg-white p-3 text-end">
             <a href="/board/list" class="btn btn-secondary">목록</a>
             <c:if test="${sessionScope.member.name == board.writer}">
                 <a href="/board/modify?id=${board.id}" class="btn btn-warning">수정</a>
                 <a href="javascript:void(0);" onclick="if(confirm('삭제하시겠습니까?')) location.href='/board/delete?id=${board.id}'" class="btn btn-danger">삭제</a>
             </c:if>
         </div>

         <div class="container mt-4 mb-5">
                 <c:if test="${not empty sessionScope.member}">
                     <div class="card mb-4 shadow-sm">
                         <div class="card-body">
                             <h5 class="card-title fw-bold">💬 댓글 달기</h5>
                             <div class="d-flex gap-2">
                                 <input type="text" id="replyer" class="form-control" style="width: 150px;" value="${sessionScope.member.name}" readonly>
                                 <input type="text" id="reply" class="form-control" placeholder="댓글 내용을 입력하세요...">
                                 <button type="button" id="replyAddBtn" class="btn btn-primary">등록</button>
                             </div>
                         </div>
                     </div>
                 </c:if>

                 <div class="card shadow-sm">
                     <div class="card-header bg-light fw-bold">
                         댓글 목록
                     </div>
                     <ul id="replyList" class="list-group list-group-flush">
                         </ul>
                 </div>
             </div>

        </div>
    </div>
<script>
        // 현재 글 번호 (이 글에 달린 댓글만 가져와야 하니까)
        const bno = "${board.id}";

        // 페이지가 열리자마자 댓글 목록 가져오기
        showList();

        // [기능 1] 댓글 목록 가져오기 (GET 방식)
        function showList() {
            fetch('/reply/list?bno=' + bno) // 서버에 "이 글 댓글 다 줘!" 요청
                .then(response => response.json()) // "JSON 데이터로 줘"
                .then(data => {
                    let html = "";
                    // 가져온 댓글 개수만큼 반복해서 HTML 만들기
                    if(data.length === 0) {
                        html += '<li class="list-group-item text-center text-muted p-4">등록된 댓글이 없습니다. 첫 댓글을 남겨보세요!</li>';
                    } else {
                        data.forEach(reply => {
                            html += `<li class="list-group-item">
                                        <div class="d-flex justify-content-between">
                                            <strong class="text-primary">\${reply.replyer}</strong>
                                            <small class="text-secondary">방금 전</small>
                                        </div>
                                        <div class="mt-1">\${reply.reply}</div>
                                     </li>`;
                        });
                    }
                    // 만든 HTML을 화면에 덮어쓰기
                    document.getElementById('replyList').innerHTML = html;
                });
        }

        // [기능 2] 댓글 등록하기 (POST 방식)
        const addBtn = document.getElementById('replyAddBtn');
        if(addBtn) { // 로그인 안 했으면 버튼이 없으므로 에러 방지
            addBtn.onclick = function() {
                const reply = document.getElementById('reply').value;
                const replyer = document.getElementById('replyer').value;

                if(reply.trim() === '') { alert('내용을 입력하세요'); return; }

                // 서버로 보낼 데이터 포장 (JSON)
                const replyData = {
                    bno: bno,
                    reply: reply,
                    replyer: replyer
                };

                fetch('/reply/write', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(replyData) // 데이터를 문자열로 변환해서 전송
                })
                .then(response => response.text())
                .then(result => {
                    if(result === 'SUCCESS') {
                        // 성공하면 입력창 비우고 목록 다시 불러오기
                        document.getElementById('reply').value = '';
                        showList();
                    } else {
                        alert('등록 실패!');
                    }
                });
            };
        }
    </script>
</body>
</html>