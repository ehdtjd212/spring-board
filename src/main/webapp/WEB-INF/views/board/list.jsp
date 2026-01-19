<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>스프링 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; } /* 배경을 은은한 회색으로 */
        .container { background-color: white; padding: 40px; border-radius: 10px; margin-top: 50px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        a { text-decoration: none; color: #333; } /* 링크 밑줄 제거 */
        a:hover { color: #0d6efd; font-weight: bold; }
    </style>
</head>
<body>

    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold text-primary">🌱 스프링 게시판</h2>
            <div>
                <c:if test="${empty sessionScope.member}">
                    <button onclick="location.href='/member/login'" class="btn btn-outline-primary fw-bold">
                        🔐 로그인
                    </button>
                </c:if>

                <c:if test="${not empty sessionScope.member}">
                    <span class="me-3 fw-bold">👋 ${sessionScope.member.name}님</span>
                    <button onclick="location.href='/member/logout'" class="btn btn-outline-danger btn-sm">
                        로그아웃
                    </button>
                    <button onclick="location.href='/board/write'" class="btn btn-primary fw-bold ms-2">
                        ✏️ 새 글 쓰기
                    </button>
                </c:if>
            </div>
        </div>

        <div class="row mb-3 justify-content-center">
                <div class="col-auto">
                    <form action="/board/list" method="get" class="d-flex">
                        <select name="option" class="form-select me-2" style="width: 100px;">
                            <option value="T" ${ph.option == 'T' ? 'selected' : ''}>제목</option>
                            <option value="W" ${ph.option == 'W' ? 'selected' : ''}>작성자</option>
                        </select>
                        <input type="text" name="keyword" value="${ph.keyword}" class="form-control me-2" placeholder="검색어 입력" style="width: 200px;">
                        <button type="submit" class="btn btn-secondary">검색</button>
                    </form>
                </div>
            </div>

        <table class="table table-hover">
            <thead class="table-light">
                <tr>
                    <th width="10%" class="text-center">번호</th>
                    <th width="50%">제목</th>
                    <th width="15%" class="text-center">작성자</th>
                    <th width="25%" class="text-center">작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="board">
                    <tr>
                        <td class="text-center">${board.id}</td>
                        <td>
                            <a href="/board/read?id=${board.id}">${board.title}</a>
                        </td>
                        <td class="text-center">${board.writer}</td>
                        <td class="text-center text-secondary" style="font-size: 0.9em;">
                            <fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <nav>
                <ul class="pagination justify-content-center">
                    <c:if test="${ph.prev}">
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${ph.begin - 1}&option=${ph.option}&keyword=${ph.keyword}">&laquo;</a>
                        </li>
                    </c:if>

                    <c:forEach begin="${ph.begin}" end="${ph.end}" var="i">
                        <li class="page-item ${ph.page == i ? 'active' : ''}">
                            <a class="page-link" href="/board/list?page=${i}&option=${ph.option}&keyword=${ph.keyword}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${ph.next}">
                        <li class="page-item">
                            <a class="page-link" href="/board/list?page=${ph.end + 1}&option=${ph.option}&keyword=${ph.keyword}">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
    </div>

</body>
</html>